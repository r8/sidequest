// Forth adapter: runs the test file under gforth with the track harness (tracks/forth/lib/test.fs) and
// maps its tab-separated report to Exercism's results.json v2. The mapping is pinned by
// tools/test/fixtures/forth/run/.
import type { Runner } from '../runner/types.ts';
import { mapHarnessRun, testSources, type HarnessSpec } from '../runner/harness.ts';
import { writeResults } from '../runner/output.ts';

const SPEC: HarnessSpec = {
  program: 'gforth',
  noSummary: 'the tests did not run to the end: the harness printed no summary (does the solution call bye, or the test file not end with end-tests?)',
  // gforth's warning when a solution redefines an existing word; it is not the test's output.
  noise: /^redefined \S+\s*$/,
};

/** The source of every `test" name" … ;test` definition, by test name. */
export function extractTests(source: string): Map<string, string> {
  const tests = new Map<string, string>();
  for (const m of source.matchAll(/(?<!\S)test" ([^"]*)"[\s\S]*?(?<!\S);test(?!\S)/g)) {
    if (!tests.has(m[1]!)) tests.set(m[1]!, m[0]);
  }
  return tests;
}

const forth: Runner = {
  async run(ctx) {
    writeResults(ctx.outputDir, mapHarnessRun(await ctx.exec(ctx.argv), testSources(ctx, extractTests), ctx.timeoutMs, SPEC));
  },
  lineComment: '\\',
};

export default forth;
