// Inko adapter: builds and runs ordinary std.test tests and maps their plain-text report to Exercism's
// results.json v2. No harness is staged. The mapping is pinned by tools/test/fixtures/inko/run/.
//
// The test binary is the one `inko test` would build, but with std.test's reporter wrapped to also name
// each test that passes (std.test prints only a dot), so the adapter knows which declared tests ran.
// Test names and their order come from the test source. A panic ends the whole test process, so when
// one happens the adapter runs the binary once per test (its first argument filters by name), all in
// one process, to isolate the panic.
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import type { ExecResult, Runner } from '../runner/types.ts';
import { MESSAGE_LIMIT, stripAnsi, truncate, writeResults } from '../runner/output.ts';
import type { Results, TestResult } from '../schema/results.ts';

// The test binary, built by ctx.argv from MAIN_SOURCE.
const MAIN_SOURCE = 'build/quest-tests.inko';
const BINARY = 'build/debug/quest-tests';
// What starts the line the adapter's binary writes to stderr for each test that passes.
const PASSED = '\x1equest-passed ';
const FINISHED = /^Finished running (\d+) tests? in .*, (\d+) failures?/m;
const UNMATCHED = 'the tests failed, but not in a test found in the test file (is a test name computed rather than a string literal?)';
// A test registration, up to its opening parenthesis.
const HEAD = String.raw`\.(?:test|ok|panic|no_panic|fork)\(`;
const NOT_RUN = 'not run: Inko did not run this test (is it registered only conditionally?)';
// The one-at-a-time runs all go in one process (under CI, one container rather than one per test): the
// shell marks where each run's output starts on both streams, and its exit status after it.
const RUN = '\x1equest-run\n';
const EXIT = /\x1equest-exit (\d+)\n$/;
const ONE_AT_A_TIME = `for name in "$@"; do printf '\\036quest-run\\n'; printf '\\036quest-run\\n' >&2; ./${BINARY} "$name"; printf '\\036quest-exit %s\\n' "$?"; done`;

const INKO_ESCAPES: Record<string, string> = { n: '\n', t: '\t', r: '\r', e: '\x1b', '0': '\0', '\\': '\\', "'": "'", '"': '"', $: '$' };

function unescapeInko(body: string): string {
  return body.replace(/\\(u\{[0-9a-fA-F]+\}|.)/g, (_, e: string) => (e.length > 1 ? String.fromCodePoint(parseInt(e.slice(2, -1), 16)) : (INKO_ESCAPES[e] ?? e)));
}

/** The source with comments and string contents blanked (quotes and newlines kept), so offsets still match. */
function codeOnly(src: string): string {
  const blank = (s: string) => s.replace(/[^\n]/g, ' ');
  return src.replace(/#[^\n]*|(['"])((?:(?!\1)[^\\]|\\[\s\S])*)(\1?)/g, (m, quote: string | undefined, body: string, close: string) =>
    quote ? quote + blank(body) + close : blank(m),
  );
}

/** Index just past the parenthesis matching the one at `open` in code from codeOnly. */
function matchParen(code: string, open: number): number {
  let depth = 0;
  for (let i = open; i < code.length; i++) {
    if (code[i] === '(') depth++;
    else if (code[i] === ')' && --depth === 0) return i + 1;
  }
  return code.length;
}

/** A test found in a test file: its name, its source, and the file and lines that source spans. */
export interface Declared {
  name: string;
  code: string;
  file: string;
  lines: [number, number];
}

/**
 * Every test registered with t.test / t.ok / t.panic / t.no_panic / t.fork, in definition order. A call
 * in a comment or a string is not a test: it would never run, so it would only ever be reported missing.
 */
export function extractTests(source: string, file = ''): Declared[] {
  const tests: Declared[] = [];
  const code = codeOnly(source);
  const lineAt = (offset: number) => source.slice(0, offset).split('\n').length;
  const head = new RegExp(`${HEAD}(?=\\s*['"])`, 'g');
  for (let m = head.exec(code); m; m = head.exec(code)) {
    // The name is read from the source, since its contents are blanked in `code`.
    const literal = /\s*(['"])((?:(?!\1)[^\\]|\\[\s\S])*)\1/y;
    literal.lastIndex = m.index + m[0].length;
    const name = literal.exec(source);
    if (!name) continue;
    const open = code.indexOf('(', m.index);
    const end = matchParen(code, open);
    const start = source.lastIndexOf('\n', m.index) + 1;
    tests.push({ name: unescapeInko(name[2]!), code: source.slice(start, end).trim(), file, lines: [lineAt(start), lineAt(end)] });
    head.lastIndex = end;
  }
  return tests;
}

/**
 * Failure messages by test name, from the "Failures:" section of std.test's plain reporter. The
 * reporter prints that section last, just before the summary, so it is the last "Failures:" line
 * there: whatever the solution printed comes earlier, and may contain the same word.
 */
export function parseFailures(stdout: string): Map<string, string[]> {
  const failures = new Map<string, string[]>();
  const finished = FINISHED.exec(stdout);
  const report = finished ? stdout.slice(0, finished.index) : stdout;
  const heading = [...report.matchAll(/^Failures:$/gm)].at(-1);
  if (!heading) return failures;
  const body = report.slice(heading.index + heading[0].length);
  for (const block of body.split(/^\d+\. Test: /m).slice(1)) {
    const m = /^([\s\S]*?)\n +Line: [^\n]*\n\n +expected: ([\s\S]*?)\n +got: ([\s\S]*?)\s*$/.exec(block);
    if (!m) continue;
    // The reporter indents continuation lines of a multi-line value; undo that.
    const value = (v: string) => v.replace(/\n {13,}/g, '\n');
    const list = failures.get(m[1]!) ?? [];
    list.push(`expected ${value(m[2]!)}, got ${value(m[3]!)}`);
    failures.set(m[1]!, list);
  }
  return failures;
}

function panicMessage(stderr: string): string | null {
  const m = /panicked: (.*)$/m.exec(stderr);
  if (!m) return null;
  const frame = [...stderr.matchAll(/^\s+(\S*\/(?:src|test)\/[^:\s]+\.inko:\d+) in /gm)].at(-1)?.[1];
  return frame ? `${m[1]} (${frame.replace(/^.*\/((?:src|test)\/)/, '$1')})` : m[1]!;
}

/**
 * The test a panic came from: the one whose source holds the outermost stack frame in a test file,
 * since std.test calls the test's closure directly.
 */
function panickedIn(stderr: string, declared: Declared[]): Declared | undefined {
  for (const [, path, line] of stderr.matchAll(/^\s+(\S+\.inko):(\d+) in /gm)) {
    const inFile = declared.filter((t) => t.file && path!.endsWith(`/${t.file}`));
    if (inFile.length) return inFile.find((t) => t.lines[0] <= Number(line) && Number(line) <= t.lines[1]);
  }
  return undefined;
}

/**
 * The main module of the adapter's test binary: what `inko test` generates, but with std.test's plain
 * reporter wrapped to write `<PASSED><name's size in bytes>:<name>` to stderr for each test that
 * passes, and its argument, if any, always a name pattern (`inko test`'s main reads one naming an
 * existing path, such as a test named "src", as the tests in that file). `modules` are the test
 * modules' import paths.
 */
export function namedMain(modules: string[]): string {
  return `import std.env
import std.stdio (Stderr, Stdout)
import std.test (Filter, Plain, Reporter, Test, Tests)
import std.time (Duration)
${modules.map((module, i) => `import ${module} (self as tests${i})`).join('\n')}

type Named {
  let @plain: Plain[Stdout]
  let @err: Stderr
}

impl Reporter for Named {
  fn pub mut passed(test: Test) {
    @err.write('\\u{1E}quest-passed \${test.name.size}:\${test.name}\\n').get
    @plain.passed(test)
  }

  fn pub mut failed(test: Test) {
    @plain.failed(test)
  }

  fn pub move finished(duration: Duration, seed: Int) -> Bool {
    @plain.finished(duration, seed)
  }
}

type async Main {
  fn async main {
    let tests = Tests.new

    tests.reporter = Named(plain: Plain.new(Stdout.new, false), err: Stderr.new) as Reporter
${modules.map((_, i) => `    tests${i}.tests(tests)`).join('\n')}
    match env.arguments.get(0) {
      case Ok(name) -> tests.filter = Filter.Pattern(name.clone)
      case _ -> {}
    }
    tests.run
  }
}
`;
}

/** The import path of a test module `inko test` runs (a test_*.inko under test/), or null for any other file. */
function testModule(file: string): string | null {
  const m = /^test\/((?:[^/]+\/)*test_[^/]+)\.inko$/.exec(file);
  return m ? m[1]!.replaceAll('/', '.') : null;
}

/** The names the adapter's binary reported passing, and its stderr without those lines. */
export function splitPassed(stderr: string): { passed: string[]; rest: string } {
  const passed: string[] = [];
  const bytes = Buffer.from(stderr);
  const mark = Buffer.from(PASSED);
  const kept: Buffer[] = [];
  let from = 0;
  for (let at = bytes.indexOf(mark); at >= 0; at = bytes.indexOf(mark, from)) {
    const header = /^(\d+):/.exec(bytes.subarray(at + mark.length, at + mark.length + 24).toString('latin1'));
    if (!header) {
      kept.push(bytes.subarray(from, at + mark.length));
      from = at + mark.length;
      continue;
    }
    const start = at + mark.length + header[0].length;
    const end = start + Number(header[1]);
    kept.push(bytes.subarray(from, at));
    passed.push(bytes.subarray(start, end).toString('utf8'));
    from = bytes[end] === 0x0a ? end + 1 : end;
  }
  kept.push(bytes.subarray(from));
  return { passed, rest: Buffer.concat(kept).toString('utf8') };
}

function results(tests: TestResult[], message: string | null = null): Results {
  return { version: 2, status: tests.some((t) => t.status !== 'pass') ? 'fail' : 'pass', message, tests };
}

const error = (message: string): Results => ({ version: 2, status: 'error', message: truncate(message, MESSAGE_LIMIT), tests: [] });

/**
 * Maps one full run of the test binary, given the tests the source declares. Null when the run did not
 * end cleanly (a panic, say) and each test must be run on its own.
 */
export function mapRun(run: ExecResult, declared: { name: string; code: string }[], timeoutMs: number): Results | null {
  if (run.timedOut) return error(`Timed out after ${timeoutMs} ms: compiling and running the tests did not finish (an infinite loop?)`);
  const stdout = stripAnsi(run.stdout);
  const { passed, rest } = splitPassed(stripAnsi(run.stderr));
  const stderr = rest.trim();
  const finished = FINISHED.exec(stdout);
  if (!finished) {
    if (panicMessage(stderr) !== null && declared.length) return null;
    return error(stderr || stdout.trim() || `inko exited with code ${run.exitCode}`);
  }
  // The summary's failure count (one per failed assertion) and the exit status are the ground truth;
  // the parsed report only says which tests they belong to. When the two disagree — a solution that
  // prints its own "Failures:" or "N. Test:" lines can garble the report — run each test on its own.
  const failed = Number(finished[2]);
  const failures = failed === 0 ? new Map<string, string[]>() : parseFailures(stdout);
  const consistent = failed === 0 ? run.exitCode === 0 : failures.size > 0 && run.exitCode !== 0;
  if (!consistent && declared.length) return null;
  if (!consistent) return { version: 2, status: 'fail', message: truncate(`${UNMATCHED}; its report:\n${stdout.trim()}`, MESSAGE_LIMIT), tests: [] };
  const names = new Set(declared.map((t) => t.name));
  const message = (messages: string[]) => truncate(messages.join('\n'), MESSAGE_LIMIT);
  // A test whose name is computed (not a string literal) is not found in the source, but its failures
  // still fail the run.
  const extra: TestResult[] = [];
  for (const [name, messages] of failures) if (!names.has(name)) extra.push({ name, status: 'fail', message: message(messages) });
  const count = Number(finished[1]);
  const warning = count === declared.length ? null : `warning: inko ran ${count} tests but the test file declares ${declared.length}`;
  // A declared test that neither passed nor failed did not run (registered only conditionally, say).
  const tests = declared.map(({ name, code }): TestResult => {
    const messages = failures.get(name);
    if (messages) return { name, status: 'fail', test_code: code, message: message(messages) };
    if (passed.includes(name)) return { name, status: 'pass', test_code: code, message: null };
    return { name, status: 'error', test_code: code, message: NOT_RUN };
  });
  tests.push(...extra);
  if (!tests.length) {
    // Tests whose names are all computed ran and passed, but none can be named; without any, none ran.
    if (!count) return error('no tests ran: the test file registers none (tests are registered with t.test)');
    return { version: 2, status: 'pass', message: `warning: inko ran ${count} tests, but none was found in the test file (tests are registered with t.test)`, tests: [] };
  }
  return results(tests, warning);
}

/**
 * Maps a run of the adapter's binary filtered to one test. The filter matches every test whose name
 * contains this one's, including any whose name is computed, so the run may include others: the binary
 * names the tests that passed, and failures and panics are told apart by name and by stack frame.
 */
export function mapSingle(run: ExecResult, test: Declared, declared: Declared[]): TestResult {
  const base = { name: test.name, test_code: test.code };
  if (run.timedOut) return { ...base, status: 'error', message: 'timed out' };
  const { passed, rest: stderr } = splitPassed(stripAnsi(run.stderr));
  if (passed.includes(test.name)) return { ...base, status: 'pass', message: null };
  const others = declared.filter((t) => t !== test && t.name.includes(test.name));
  const panic = panicMessage(stderr);
  if (panic !== null) {
    const culprit = panickedIn(stderr, declared);
    if (culprit && culprit !== test && others.includes(culprit)) {
      return { ...base, status: 'error', message: `not run on its own: Inko's test filter also selects "${culprit.name}", which panicked first` };
    }
    const note = others.length && !culprit ? ` (Inko's test filter also selects ${others.map((t) => `"${t.name}"`).join(', ')}, so the panic may be theirs)` : '';
    return { ...base, status: 'error', message: truncate(panic + note, MESSAGE_LIMIT) };
  }
  const stdout = stripAnsi(run.stdout);
  const finished = FINISHED.exec(stdout);
  const notRun: TestResult = { ...base, status: 'error', message: NOT_RUN };
  if (run.exitCode === 0 && finished && Number(finished[2]) === 0) return notRun;
  const failures = parseFailures(stdout);
  const messages = failures.get(test.name);
  if (messages && run.exitCode !== 0) return { ...base, status: 'fail', message: truncate(messages.join('\n'), MESSAGE_LIMIT) };
  // Every failure belongs to another selected test, and together they account for the whole count.
  const counted = [...failures.values()].reduce((n, list) => n + list.length, 0);
  if (finished && failures.size && counted === Number(finished[2])) return notRun;
  if (finished && run.exitCode !== 0) return { ...base, status: 'fail', message: `the test failed, but its report could not be read:\n${truncate(stdout.trim(), MESSAGE_LIMIT)}` };
  return { ...base, status: 'error', message: truncate(stderr.trim() || `exited with code ${run.exitCode}`, MESSAGE_LIMIT) };
}

/**
 * The runs in a one-at-a-time process, in order, as if each had been a process of its own. The last
 * may be cut short by a timeout; the runs it left out are missing.
 */
export function splitRuns(run: ExecResult): ExecResult[] {
  const errs = run.stderr.split(RUN).slice(1);
  return run.stdout
    .split(RUN)
    .slice(1)
    .map((stdout, i) => {
      const exit = EXIT.exec(stdout);
      const stderr = errs[i] ?? '';
      if (exit) return { exitCode: Number(exit[1]), stdout: stdout.slice(0, exit.index), stderr, timedOut: false };
      return { exitCode: null, stdout, stderr, timedOut: run.timedOut };
    });
}

const inko: Runner = {
  async run(ctx) {
    const sources = ctx.testFiles.map((file) => ({ file, path: join(ctx.inputDir, file) })).filter(({ path }) => existsSync(path));
    const declared = sources.flatMap(({ file, path }) => extractTests(readFileSync(path, 'utf8'), file));
    const modules = ctx.testFiles.map(testModule).filter((m) => m !== null);
    const deadline = Date.now() + ctx.timeoutMs;
    // ctx.argv builds the main module named after it; the binary then runs every test.
    const build = `mkdir -p build && printf '%s' "$1" > ${MAIN_SOURCE} && shift && "$@" ${MAIN_SOURCE} && exec ./${BINARY}`;
    const mapped = mapRun(await ctx.exec(['sh', '-c', build, 'sh', namedMain(modules), ...ctx.argv]), declared, ctx.timeoutMs);
    if (mapped) {
      writeResults(ctx.outputDir, mapped);
      return;
    }
    const runs = splitRuns(await ctx.exec(['sh', '-c', ONE_AT_A_TIME, 'sh', ...declared.map((t) => t.name)], { timeoutMs: Math.max(deadline - Date.now(), 1) }));
    const tests = declared.map((test, i): TestResult => {
      const run = runs[i];
      if (!run) return { name: test.name, status: 'error', test_code: test.code, message: `not run: the ${ctx.timeoutMs} ms budget ran out` };
      return mapSingle(run, test, declared);
    });
    // The full run did not end cleanly; if every declared test passes alone, the culprit is a test the
    // source scan missed.
    if (tests.every((t) => t.status === 'pass')) tests.push({ name: 'tests not found in the test file', status: 'fail', message: UNMATCHED });
    writeResults(ctx.outputDir, results(tests));
  },
  lineComment: '#',
};

export default inko;
