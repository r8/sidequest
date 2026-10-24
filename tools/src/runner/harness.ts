// What the adapters of tracks with their own harness (Janet, Koka, BQN, Forth) share: reading the report
// the harness prints and deciding what a run results in, so every such track holds runs to the same checks.
//
// The report is one record per test, `STATUS<TAB>name<TAB>message<TAB>output` with STATUS one of PASS,
// FAIL and ERROR, the fields escaped (\\ \t \n \r), and the output field empty where the harness does
// not capture a test's output; then `SUMMARY<TAB>passed<TAB>failed<TAB>errored` once every test has run.
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import { MESSAGE_LIMIT, stripAnsi, summaryMismatch, truncate } from './output.ts';
import type { ExecResult, RunContext } from './types.ts';
import type { Results, TestResult } from '../schema/results.ts';

const STATUS = { PASS: 'pass', FAIL: 'fail', ERROR: 'error' } as const;
const RECORD = /^(PASS|FAIL|ERROR)\t([^\t]*)\t([^\t]*)\t([^\t]*)$/;

function unescape(field: string): string {
  return field.replace(/\\([\\tnr])/g, (_, c: string) => ({ '\\': '\\', t: '\t', n: '\n', r: '\r' })[c]!);
}

/** How a track's harness and the program running it differ from the others. */
export interface HarnessSpec {
  /** The program that runs the tests, for "<program> exited with code N". */
  program: string;
  /** Why the summary is missing when the program exited 0: what in a solution or test file stops it early. */
  noSummary: string;
  /** What did not finish when the run timed out. */
  running?: string;
  /** Lines the program prints that are not the tests' output, on stdout or stderr. */
  noise?: RegExp;
  /** Output that means the program crashed, though it exited 0. */
  crash?: RegExp;
  /** The harness captures each test's output into its record: other lines are no test's output. */
  capturesOutput?: boolean;
}

/** The source of each test the test files define, by name; the first definition of a name wins. */
export function testSources(ctx: RunContext, extract: (source: string) => Map<string, string>): Map<string, string> {
  const sources = new Map<string, string>();
  for (const file of ctx.testFiles) {
    const path = join(ctx.inputDir, file);
    if (!existsSync(path)) continue;
    for (const [name, code] of extract(readFileSync(path, 'utf8'))) if (!sources.has(name)) sources.set(name, code);
  }
  return sources;
}

/**
 * Maps one harness run to results.json v2; `sources` gives each test's code by name. Lines outside the
 * records are the output of the test whose record follows them, unless the harness captures output.
 * The run passes only when the harness printed its summary, the summary agrees with the records read,
 * and the program exited 0.
 */
export function mapHarnessRun(run: ExecResult, sources: Map<string, string>, timeoutMs: number, spec: HarnessSpec): Results {
  if (run.timedOut) {
    return { version: 2, status: 'error', message: `Timed out after ${timeoutMs} ms: ${spec.running ?? 'the tests'} did not finish (an infinite loop?)`, tests: [] };
  }
  const meaningful = (line: string) => line.trim() !== '' && !spec.noise?.test(line);
  const tests: TestResult[] = [];
  let pending: string[] = [];
  const stray: string[] = [];
  let summary: string | null = null;
  for (const line of stripAnsi(run.stdout).split('\n')) {
    const m = RECORD.exec(line);
    if (m) {
      const name = unescape(m[2]!);
      const message = unescape(m[3]!);
      if (spec.capturesOutput) stray.push(...pending.splice(0));
      const output = (pending.length ? pending.join('\n') + '\n' : '') + unescape(m[4]!);
      tests.push({
        name,
        status: STATUS[m[1] as keyof typeof STATUS],
        test_code: sources.get(name) ?? null,
        message: message ? truncate(message, MESSAGE_LIMIT) : null,
        output: output ? truncate(output) : null,
      });
      pending = [];
    } else if (line.startsWith('SUMMARY\t')) {
      summary = line;
    } else if (meaningful(line)) {
      pending.push(line);
    }
  }
  // gforth's error display pads the offending source line with NUL bytes.
  const stderr = stripAnsi(run.stderr).replaceAll('\0', '').split('\n').filter((l) => !spec.noise?.test(l)).join('\n').trim();
  const leftover = [[...stray, ...pending].join('\n').trim(), stderr].filter(Boolean).join('\n');
  const error = (message: string): Results => ({ version: 2, status: 'error', message: truncate(message, MESSAGE_LIMIT), tests });
  if (!summary) {
    // A load error, an error outside any test, or a solution that exits: the harness never finished,
    // so whatever tests did report, the run is not a pass.
    const early = run.exitCode === 0 && !spec.crash?.test(leftover);
    return error(early ? [spec.noSummary, leftover].filter(Boolean).join('\n') : leftover || `${spec.program} exited with code ${run.exitCode}`);
  }
  const mismatch = summaryMismatch(summary, tests);
  if (mismatch) return error([mismatch, leftover].filter(Boolean).join('\n'));
  // A test file that registers nothing passes nothing: it says nothing about the solution.
  if (!tests.length) return error(['no tests ran: the test file registers none', leftover].filter(Boolean).join('\n'));
  const anyFailed = tests.some((t) => t.status !== 'pass');
  // Every reported test passed but the program failed afterwards: something outside the tests broke.
  if (!anyFailed && run.exitCode !== 0) return error(leftover || `${spec.program} exited with code ${run.exitCode}`);
  return { version: 2, status: anyFailed ? 'fail' : 'pass', message: null, tests };
}
