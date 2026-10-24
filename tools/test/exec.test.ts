import { test } from 'node:test';
import assert from 'node:assert/strict';
import { tmpdir } from 'node:os';
import { spawn, spawnSync } from 'node:child_process';
import { QuestError } from '../src/core/errors.ts';
import { makeExec, spawnWithTimeout } from '../src/runner/exec.ts';
import type { Track } from '../src/core/track.ts';
import { substituteArgv } from '../src/runner/run.ts';

const alive = (marker: string) => spawnSync('pgrep', ['-f', marker]).status === 0;

test('a timeout kills the whole process group, grandchildren included', async () => {
  const marker = `sleep 3${process.pid % 1000}.5`;
  const started = Date.now();
  const r = await spawnWithTimeout(['sh', '-c', `${marker} & ${marker}; echo never`], { cwd: tmpdir(), env: process.env, timeoutMs: 300 });
  assert.equal(r.timedOut, true);
  assert.equal(r.exitCode, null);
  assert.ok(Date.now() - started < 5000);
  await new Promise((res) => setTimeout(res, 100));
  assert.equal(alive(marker), false, 'no process may be left behind');
});

test('an interrupted quest kills the process groups of the tests it was running', async () => {
  const marker = `sleep 4${process.pid % 1000}.5`;
  const exec = new URL('../src/runner/exec.ts', import.meta.url).href;
  // A stand-in for quest: starts a test process the way runs do, says so, and waits for it.
  const script = `
    const { spawnWithTimeout } = await import(${JSON.stringify(exec)});
    const run = spawnWithTimeout(['sh', '-c', '${marker} & ${marker}'], { cwd: ${JSON.stringify(tmpdir())}, env: process.env, timeoutMs: 60000 });
    console.log('started');
    await run;`;
  const quest = spawn(process.execPath, ['--input-type=module', '-e', script], { stdio: ['ignore', 'pipe', 'inherit'] });
  await new Promise<void>((resolve) => quest.stdout.on('data', () => resolve()));
  while (!alive(marker)) await new Promise((res) => setTimeout(res, 20));
  quest.kill('SIGINT');
  const code = await new Promise((resolve) => quest.on('close', resolve));
  assert.equal(code, 130);
  await new Promise((res) => setTimeout(res, 100));
  assert.equal(alive(marker), false, 'the test process must not outlive quest');
});

test('exit code, stdout and stderr are captured', async () => {
  const r = await spawnWithTimeout(['sh', '-c', 'echo out; echo err >&2; exit 3'], { cwd: tmpdir(), env: process.env, timeoutMs: 5000 });
  assert.deepEqual(r, { exitCode: 3, stdout: 'out\n', stderr: 'err\n', timedOut: false });
});

test('a program that cannot be started is a tooling error, not a result', async () => {
  await assert.rejects(
    spawnWithTimeout(['quest-no-such-program'], { cwd: tmpdir(), env: process.env, timeoutMs: 5000 }),
    (err) => err instanceof QuestError && /could not start quest-no-such-program: .*ENOENT/.test(err.message),
  );
});

test('a program mise cannot start is a tooling error too, but a failing one is a result', async () => {
  const track = { quest: { toolchain: null } } as unknown as Track;
  const exec = makeExec({ track, inputDir: tmpdir(), mountDir: tmpdir(), timeoutMs: 10000, env: {} });
  await assert.rejects(
    exec(['quest-no-such-program']),
    (err) => err instanceof QuestError && /mise could not start quest-no-such-program: .*quest-no-such-program/.test(err.message),
  );
  const r = await exec(['sh', '-c', 'echo err >&2; exit 1']);
  assert.deepEqual([r.exitCode, r.stderr], [1, 'err\n']);
});

test('argv placeholders', () => {
  assert.deepEqual(substituteArgv(['janet', '{test}'], ['test/a.janet', 'test/b.janet']), ['janet', 'test/a.janet']);
  assert.deepEqual(substituteArgv(['run', '{tests}'], ['a', 'b']), ['run', 'a', 'b']);
});
