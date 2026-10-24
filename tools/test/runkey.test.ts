// What the run key covers beyond the staged files.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { computeRunKey } from '../src/core/runkey.ts';
import type { TestBlock } from '../src/schema/quest-json.ts';

const block: TestBlock = { argv: ['janet', '{test}'], env: {}, timeoutMs: 30000 };

test('changing the runner adapter, or switching to another, changes the key', () => {
  const key = (name: string, source: string | null) => computeRunKey([], block, '1.0.0', { name, source: source === null ? null : Buffer.from(source), shared: [] });
  const base = key('janet', 'export default {}');
  assert.equal(key('janet', 'export default {}'), base);
  assert.notEqual(key('janet', 'export default { changed: true }'), base);
  assert.notEqual(key('forth', 'export default {}'), base);
  assert.notEqual(key('janet', null), base);
});

test('changing a shared module the adapter runs with changes the key', () => {
  const key = (shared: [string, string][]) =>
    computeRunKey([], block, '1.0.0', { name: 'janet', source: Buffer.from('export default {}'), shared: shared.map(([path, source]) => ({ path, source: Buffer.from(source) })) });
  const base = key([['runner/output.ts', 'a'], ['runner/exec.ts', 'b']]);
  assert.equal(key([['runner/exec.ts', 'b'], ['runner/output.ts', 'a']]), base, 'order does not matter');
  assert.notEqual(key([['runner/output.ts', 'a changed'], ['runner/exec.ts', 'b']]), base);
  assert.notEqual(key([['runner/exec.ts', 'b']]), base);
});
