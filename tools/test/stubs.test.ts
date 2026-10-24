import { test } from 'node:test';
import assert from 'node:assert/strict';
import { stubProblem } from '../src/commands/test.ts';
import type { CachedResult } from '../src/schema/results.ts';

const result = (status: CachedResult['status'], tests: CachedResult['tests'], message: string | null = null) =>
  ({ status, message, tests, version: 2 }) as unknown as CachedResult;
const failing = { name: 'greets', status: 'fail', message: 'implement me' } as CachedResult['tests'][number];
const passing = { name: 'greets', status: 'pass', message: null } as CachedResult['tests'][number];

test('a stub must load and fail its tests', () => {
  assert.equal(stubProblem(result('fail', [failing])), null);
  assert.match(stubProblem(result('pass', [passing]))!, /passes/);
  // A run that reported a test and then stopped is not a stub failing its tests.
  assert.match(stubProblem(result('error', [passing], 'the harness printed no summary\nmore'))!, /errored: the harness printed no summary$/);
  assert.match(stubProblem(result('fail', [], 'could not read the report'))!, /no tests ran/);
});
