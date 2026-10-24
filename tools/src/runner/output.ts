// Helpers every adapter uses on harness output before and after parsing it.
import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import type { Results, TestResult } from '../schema/results.ts';

// CSI and OSC escape sequences.
const ANSI = /\x1b\[[0-?]*[ -\/]*[@-~]|\x1b\][^\x07\x1b]*(?:\x07|\x1b\\)/g;

export function stripAnsi(text: string): string {
  return text.replace(ANSI, '');
}

export const OUTPUT_LIMIT = 2000;
export const MESSAGE_LIMIT = 8000;

/** Keeps the head and the tail of a long text with a marker in between. */
export function truncate(text: string, limit = OUTPUT_LIMIT): string {
  if (text.length <= limit) return text;
  const half = Math.floor((limit - 40) / 2);
  const dropped = text.length - 2 * half;
  return `${text.slice(0, half)}\n… [${dropped} characters truncated] …\n${text.slice(-half)}`;
}

/**
 * Checks a harness's `SUMMARY<TAB>passed<TAB>failed<TAB>errored` line against the records read. A record
 * the parser missed (glued to output the solution printed without a newline, say) must not let a run
 * pass on the tests that remain. The problem, or null when they agree.
 */
export function summaryMismatch(summary: string, tests: TestResult[]): string | null {
  const m = /^SUMMARY\t(\d+)\t(\d+)\t(\d+)\s*$/.exec(summary);
  if (!m) return `the harness's summary line could not be read: ${summary}`;
  const reported = [Number(m[1]), Number(m[2]), Number(m[3])];
  const read = (['pass', 'fail', 'error'] as const).map((status) => tests.filter((t) => t.status === status).length);
  if (reported.every((n, i) => n === read[i])) return null;
  return `the harness reported ${reported[0]} passed, ${reported[1]} failed and ${reported[2]} errored, but ${read[0]}, ${read[1]} and ${read[2]} could be read from its output (does the solution print without a trailing newline?)`;
}

export function writeResults(outputDir: string, results: Results): void {
  mkdirSync(outputDir, { recursive: true });
  writeFileSync(join(outputDir, 'results.json'), JSON.stringify(results, null, 2) + '\n');
}
