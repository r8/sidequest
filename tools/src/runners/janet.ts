// Janet adapter: runs the track harness (tracks/janet/lib/test.janet) and maps its tab-separated
// report to Exercism's results.json v2. The mapping is pinned by tools/test/fixtures/janet/.
import { posix } from 'node:path';
import type { ExerciseMeta, Runner } from '../runner/types.ts';
import { isGroup, type CanonicalCase, type CanonicalData, type CanonicalNode } from '../schema/canonical.ts';
import { mapHarnessRun, testSources, type HarnessSpec } from '../runner/harness.ts';
import { writeResults } from '../runner/output.ts';

const SPEC: HarnessSpec = {
  program: 'janet',
  noSummary: 'the tests did not run to the end: the harness printed no summary (does the solution call os/exit, or the test file not end with (t/run)?)',
  capturesOutput: true,
};

const JANET_ESCAPES: Record<string, string> = { n: '\n', t: '\t', r: '\r', '0': '\0', z: '\0', f: '\f', v: '\v', e: '\x1b', a: '\x07', b: '\b', '"': '"', '\\': '\\', "'": "'", '?': '?' };

/** The value of a Janet string literal's body (between the quotes). */
export function unescapeJanetString(body: string): string {
  return body.replace(/\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|U[0-9a-fA-F]{6}|.)/g, (_, e: string) => {
    if (e.length > 1) return String.fromCodePoint(parseInt(e.slice(1), 16));
    return JANET_ESCAPES[e] ?? e;
  });
}

/**
 * The source of every `(deftest "name" …)` form in a Janet file, by test name. Balanced-paren
 * extraction that skips strings, long strings and comments; the head may carry a module prefix (t/deftest).
 */
export function extractDeftests(source: string): Map<string, string> {
  const forms = new Map<string, string>();
  const opens: number[] = [];
  for (let i = 0; i < source.length; i++) {
    const c = source[i]!;
    if (c === '#') {
      while (i < source.length && source[i] !== '\n') i++;
    } else if (c === '"') {
      for (i++; i < source.length && source[i] !== '"'; i++) if (source[i] === '\\') i++;
    } else if (c === '`') {
      let n = 0;
      while (source[i + n] === '`') n++;
      const fence = '`'.repeat(n);
      const end = source.indexOf(fence, i + n);
      i = end === -1 ? source.length : end + n - 1;
    } else if (c === '(' || c === '[' || c === '{') {
      opens.push(i);
    } else if (c === ')' || c === ']' || c === '}') {
      const start = opens.pop();
      if (start === undefined || source[start] !== '(') continue;
      const form = source.slice(start, i + 1);
      const head = /^\(\s*(?:[^\s()\[\]{}"]+\/)?deftest\s+"((?:[^"\\]|\\.)*)"/.exec(form);
      if (head) {
        const name = unescapeJanetString(head[1]!);
        if (!forms.has(name)) forms.set(name, form);
      }
    }
  }
  return forms;
}

// --- Test generation: canonical-data.json → a test file for the harness ---

/** A JSON value as a Janet literal: arrays become tuples, objects structs with string keys. */
export function janetLiteral(value: unknown): string {
  if (value === null || value === undefined) return 'nil';
  if (typeof value === 'boolean' || typeof value === 'number') return String(value);
  if (typeof value === 'string') {
    const body = value.replace(/[\\"\x00-\x1f\x7f]/g, (c) => {
      const named: Record<string, string> = { '\\': '\\\\', '"': '\\"', '\n': '\\n', '\t': '\\t', '\r': '\\r' };
      return named[c] ?? `\\x${c.charCodeAt(0).toString(16).padStart(2, '0')}`;
    });
    return `"${body}"`;
  }
  if (Array.isArray(value)) return `[${value.map(janetLiteral).join(' ')}]`;
  return `{${Object.entries(value as Record<string, unknown>).map(([k, v]) => `${janetLiteral(k)} ${janetLiteral(v)}`).join(' ')}}`;
}

/** camelCase property → Janet name: kebab-case, with isFoo → foo? for predicates. */
export function janetName(property: string): string {
  const predicate = /^is[A-Z]/.test(property);
  const base = predicate ? property.slice(2) : property;
  const kebab = base.replace(/([a-z0-9])([A-Z])/g, '$1-$2').replace(/_/g, '-').toLowerCase();
  return predicate ? `${kebab}?` : kebab;
}

function assertion(c: CanonicalCase): string {
  const call = `(sol/${janetName(c.property)}${Object.values(c.input).map((v) => ` ${janetLiteral(v)}`).join('')})`;
  const expected = c.expected;
  if (expected && typeof expected === 'object' && !Array.isArray(expected) && 'error' in expected) {
    return `(t/assert-error ${janetLiteral((expected as { error: unknown }).error)} ${call})`;
  }
  if (expected === true) return `(t/assert-true ${call})`;
  if (expected === false) return `(t/assert-false ${call})`;
  return `(t/assert-equal ${janetLiteral(expected)} ${call})`;
}

function flatten(nodes: CanonicalNode[], path: string[] = []): { c: CanonicalCase; path: string[] }[] {
  return nodes.flatMap((n) => (isGroup(n) ? flatten(n.cases, [...path, n.description]) : [{ c: n, path }]));
}

export function generateTests(canonical: CanonicalData, exercise: ExerciseMeta): Record<string, string> {
  const solution = exercise.files.solution[0]!.replace(/\.janet$/, '');
  const files: Record<string, string> = {};
  for (const testFile of exercise.files.test) {
    let rel = posix.relative(posix.dirname(testFile), solution);
    if (!rel.startsWith('.')) rel = `./${rel}`;
    const seen = new Set<string>();
    const forms = flatten(canonical.cases).map(({ c, path }) => {
      let name = c.description;
      if (seen.has(name)) name = [...path, c.description].join(' > ');
      for (let i = 2; seen.has(name); i++) name = `${c.description} (${i})`;
      seen.add(name);
      return `(t/deftest ${janetLiteral(name)}\n  ${assertion(c)})`;
    });
    files[testFile] = `(import test :as t)\n(import ${rel} :as sol)\n\n${forms.join('\n\n')}\n\n(t/run)\n`;
  }
  return files;
}

const janet: Runner = {
  async run(ctx) {
    writeResults(ctx.outputDir, mapHarnessRun(await ctx.exec(ctx.argv), testSources(ctx, extractDeftests), ctx.timeoutMs, SPEC));
  },
  generateTests,
  lineComment: '#',
};

export default janet;
