import { test } from 'node:test';
import assert from 'node:assert/strict';
import { fileURLToPath } from 'node:url';
import { syncOutcome } from '../src/commands/validate.ts';
import { validateTrack } from '../src/core/validate.ts';

const root = fileURLToPath(new URL('../../', import.meta.url));
const fixture = (name: string) => fileURLToPath(new URL(`./fixtures/${name}`, import.meta.url));

test('validate names the file and the field of a bad quest.json', () => {
  const report = validateTrack(fixture('bad-quest-json'), root);
  assert.equal(report.track, null);
  assert.ok(report.errors.some((e) => e.includes('bad-quest-json/quest.json: runner:')), report.errors.join('\n'));
  assert.ok(report.errors.some((e) => e.includes('bad-quest-json/quest.json: test.timeoutMs:')), report.errors.join('\n'));
});

test('configlet sync: unsynced exercises are drift, a check that never got to them failed', () => {
  assert.equal(syncOutcome(0, "Updating cached 'problem-specifications' data...\nChecking exercises...\nEvery exercise has up-to-date docs, filepaths, metadata, and tests!\n"), 'synced');
  const drift = "Updating cached 'problem-specifications' data...\nChecking exercises...\n[warn] leap: missing 1 test case\n       - year not divisible by 4 in common year (6466b30d-519c-438e-935d-388224ab5223)\n[warn] some exercises are missing test cases\n";
  assert.equal(syncOutcome(1, drift), 'drift');
  // A cache it cannot update (as under a sandbox), and no cache at all with --offline (configlet 4.0.2).
  assert.equal(syncOutcome(1, "Updating cached 'problem-specifications' data...\nfatal: Unable to create '/Users/me/.cache/exercism/configlet/problem-specifications/.git/index.lock': Operation not permitted\n"), 'failed');
  assert.equal(syncOutcome(1, "Error: --offline was passed, but there is no cached 'problem-specifications' repo at:\n'/tmp/nocache/exercism/configlet/problem-specifications'\n"), 'failed');
  assert.equal(syncOutcome(null, 'spawn mise ENOENT'), 'failed');
});
