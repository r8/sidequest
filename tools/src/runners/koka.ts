// Koka adapter: compiles and runs the test file with the track harness (tracks/koka/lib/test.kk) and
// maps its tab-separated report to Exercism's results.json v2. Builds go to the persistent
// ctx.buildDir with a fixed output directory, so the standard library and kklib are set up once; the
// rest of that directory is cleared before every compile. The mapping is pinned by
// tools/test/fixtures/koka/run/.
import { existsSync, readdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import type { Runner } from '../runner/types.ts';
import { mapHarnessRun, testSources, type HarnessSpec } from '../runner/harness.ts';
import { writeResults } from '../runner/output.ts';

const SPEC: HarnessSpec = {
  program: 'koka',
  noSummary: 'the tests did not run to the end: the harness printed no summary (does the solution exit early, or main not call run(...)?)',
  running: 'compiling and running the tests',
  // Compiler chatter that --verbose=0 still prints, and koka's note that the test binary exited non-zero.
  noise: /^(vfs:|compile\s*:|error\s*: command failed \(exit code \d+\)|command:)/,
  // Koka exits 0 on an uncaught exception.
  crash: /^uncaught exception:/m,
};

/** Skips a Koka string literal (plain or raw r"…", r#"…"#) starting at `i`; returns the index after it. */
function skipString(src: string, i: number): number {
  if (src[i] === 'r') {
    let j = i + 1;
    let hashes = 0;
    while (src[j] === '#') (hashes++, j++);
    const close = '"' + '#'.repeat(hashes);
    const end = src.indexOf(close, j + 1);
    return end === -1 ? src.length : end + close.length;
  }
  let j = i + 1;
  while (j < src.length && src[j] !== '"') j += src[j] === '\\' ? 2 : 1;
  return j + 1;
}

/** Index just past the bracket matching the one at `open`, skipping strings and comments. */
function matchBracket(src: string, open: number): number {
  const pairs: Record<string, string> = { '(': ')', '[': ']', '{': '}' };
  const stack: string[] = [];
  for (let i = open; i < src.length; i++) {
    const c = src[i]!;
    if (c === '/' && src[i + 1] === '/') {
      while (i < src.length && src[i] !== '\n') i++;
    } else if (c === '/' && src[i + 1] === '*') {
      const end = src.indexOf('*/', i + 2);
      i = end === -1 ? src.length : end + 1;
    } else if (c === '"' || (c === 'r' && /^r#*"/.test(src.slice(i, i + 10)) && !/[\w-]/.test(src[i - 1] ?? ''))) {
      i = skipString(src, i) - 1;
    } else if (pairs[c]) {
      stack.push(pairs[c]);
    } else if (c === stack.at(-1)) {
      stack.pop();
      if (!stack.length) return i + 1;
    }
  }
  return src.length;
}

/** The source of every `test("name") { … }` / `test("name", fn() …)` call, by test name. */
export function extractTests(source: string): Map<string, string> {
  const tests = new Map<string, string>();
  const head = /(?<![\w-])test\(\s*"((?:[^"\\]|\\.)*)"/g;
  for (let m = head.exec(source); m; m = head.exec(source)) {
    const open = m.index + 'test'.length;
    let end = matchBracket(source, open);
    const block = /^[ \t]*\{/.exec(source.slice(end));
    if (block) end = matchBracket(source, end + block[0].length - 1);
    const name = m[1]!.replace(/\\(.)/g, (_, c: string) => ({ n: '\n', t: '\t', r: '\r' })[c] ?? c);
    if (!tests.has(name)) tests.set(name, source.slice(m.index, end));
    head.lastIndex = end;
  }
  return tests;
}

const koka: Runner = {
  async run(ctx) {
    const sources = testSources(ctx, extractTests);
    const [compiler, ...rest] = ctx.argv;
    // A fixed --outputdir: by default Koka hashes the (per-run) staging paths into the output
    // directory name, which would rebuild into a fresh directory on every run.
    const build = ctx.buildDir!;
    const out = join(build, 'out');
    // Only the standard library and kklib are kept between runs. Koka judges a module's output current
    // by timestamps, so the output of another run's module of the same name (the example, or an earlier
    // solution) would otherwise be taken for this run's source.
    if (existsSync(out)) for (const entry of readdirSync(out)) if (!/^(std_|kklib\.)/.test(entry)) rmSync(join(out, entry), { recursive: true, force: true });
    const run = await ctx.exec([compiler!, `--builddir=${build}`, `--outputdir=${out}`, ...rest]);
    writeResults(ctx.outputDir, mapHarnessRun(run, sources, ctx.timeoutMs, SPEC));
  },
  usesBuildDir: true,
  lineComment: '//',
};

export default koka;
