// The build-directory lock shared by quest processes.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawn, spawnSync } from 'node:child_process';
import { existsSync, mkdirSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { withLock } from '../src/core/lock.ts';

function tempLock(t: { after(fn: () => void): void }): string {
  const dir = mkdtempSync(join(tmpdir(), 'quest-lock-'));
  t.after(() => rmSync(dir, { recursive: true, force: true }));
  return join(dir, 'build.lock');
}

/** A lock as a process that has since exited left it. */
function abandoned(path: string): void {
  const gone = spawnSync(process.execPath, ['-e', '']).pid!;
  mkdirSync(path);
  writeFileSync(join(path, `${gone}-left-behind`), '');
}

test('holders take turns, and the lock is released afterwards', async (t) => {
  const path = tempLock(t);
  const events: string[] = [];
  let waited = 0;
  const hold = (name: string) =>
    withLock(
      path,
      async () => {
        events.push(`${name} in`);
        await new Promise((resolve) => setTimeout(resolve, 150));
        events.push(`${name} out`);
      },
      () => waited++,
    );
  await Promise.all([hold('a'), hold('b')]);
  assert.deepEqual(events, ['a in', 'a out', 'b in', 'b out']);
  assert.equal(waited, 1);
  assert.ok(!existsSync(path));
});

test('a lock left by a process that is gone is taken over without waiting', async (t) => {
  const path = tempLock(t);
  abandoned(path);
  let waited = false;
  assert.equal(await withLock(path, async () => 'ran', () => (waited = true)), 'ran');
  assert.equal(waited, false);
});

test('a lock abandoned half-way (no owner entry) or in the old single-file form is taken over', async (t) => {
  const path = tempLock(t);
  mkdirSync(path);
  assert.equal(await withLock(path, async () => 'ran'), 'ran');
  writeFileSync(path, '');
  assert.equal(await withLock(path, async () => 'ran'), 'ran');
});

test('processes that find the same dead owner at once still hold the lock one at a time', async (t) => {
  const path = tempLock(t);
  const log = `${path}.log`;
  abandoned(path);
  const lockModule = new URL('../src/core/lock.ts', import.meta.url).href;
  const worker = `
    import { appendFileSync } from 'node:fs';
    const { withLock } = await import(${JSON.stringify(lockModule)});
    await withLock(${JSON.stringify(path)}, async () => {
      appendFileSync(${JSON.stringify(log)}, 'in\\n');
      await new Promise((resolve) => setTimeout(resolve, 20));
      appendFileSync(${JSON.stringify(log)}, 'out\\n');
    });`;
  const runs = Array.from({ length: 8 }, () =>
    new Promise<number | null>((resolve) => spawn(process.execPath, ['--input-type=module', '-e', worker], { stdio: 'inherit' }).on('close', resolve)),
  );
  assert.deepEqual(await Promise.all(runs), Array(8).fill(0));
  assert.equal(readFileSync(log, 'utf8'), 'in\nout\n'.repeat(8));
});
