// BQN adapter: runs the test file under CBQN with the track harness (tracks/bqn/lib/test.bqn) and maps
// its tab-separated report to Exercism's results.json v2. The mapping is pinned by
// tools/test/fixtures/bqn/run/.
import type { Runner } from '../runner/types.ts';
import { mapHarnessRun, testSources, type HarnessSpec } from '../runner/harness.ts';
import { writeResults } from '../runner/output.ts';

const SPEC: HarnessSpec = {
  program: 'bqn',
  noSummary: 'the tests did not run to the end: the harness printed no summary (does the solution call •Exit, or the test file not call t.Run?)',
};

/** Index just past the brace matching the one at `open`, skipping strings, characters and comments. */
function matchBrace(src: string, open: number): number {
  let depth = 0;
  for (let i = open; i < src.length; i++) {
    const c = src[i]!;
    if (c === '#') {
      while (i < src.length && src[i] !== '\n') i++;
    } else if (c === '"') {
      // BQN strings have no backslash escapes; "" stands for one quote.
      for (i++; i < src.length; i++) if (src[i] === '"') { if (src[i + 1] === '"') i++; else break; }
    } else if (c === "'") {
      i += [...src.slice(i + 1, i + 3)][0]!.length + 1; // a character literal: 'x', where x may be any code point
    } else if (c === '{' || c === '(' || c === '⟨' || c === '[') {
      depth++;
    } else if (c === '}' || c === ')' || c === '⟩' || c === ']') {
      if (--depth === 0) return i + 1;
    }
  }
  return src.length;
}

/** The source of every `"name"‿{…}` test pair, by test name. */
export function extractTests(source: string): Map<string, string> {
  const tests = new Map<string, string>();
  const head = /"((?:[^"]|"")*)"‿\{/g;
  for (let m = head.exec(source); m; m = head.exec(source)) {
    const end = matchBrace(source, m.index + m[0].length - 1);
    const name = m[1]!.replaceAll('""', '"');
    if (!tests.has(name)) tests.set(name, source.slice(m.index, end));
    head.lastIndex = end;
  }
  return tests;
}

const bqn: Runner = {
  async run(ctx) {
    writeResults(ctx.outputDir, mapHarnessRun(await ctx.exec(ctx.argv), testSources(ctx, extractTests), ctx.timeoutMs, SPEC));
  },
  lineComment: '#',
};

export default bqn;
