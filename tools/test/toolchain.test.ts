// The no-binaries toolchain path: quest.json.toolchain, doctor's version
// enforcement, the run key from the observed version, toolchain --install-ci and the ci.image executor.
// The track under test is janet with a toolchain block whose versionCommand is a stand-in, so no extra
// tool has to be installed; janet itself is put on PATH as the "host" binary.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { exampleOf, repo, tempRepo } from './helpers.ts';
import { makeExec, wrapArgv } from '../src/runner/exec.ts';
import type { Track } from '../src/core/track.ts';
import type { Toolchain } from '../src/schema/quest-json.ts';

const janet = spawnSync('mise', ['which', 'janet'], { cwd: repo, encoding: 'utf8' });
const hasJanet = janet.status === 0;

function withToolchain(r: ReturnType<typeof tempRepo>, toolchain: Partial<Toolchain>): void {
  const quest = JSON.parse(r.read('tracks/janet/quest.json'));
  quest.toolchain = { bin: 'janet', version: 'fake-1.0', versionCommand: ['sh', '-c', 'echo "Janet fake-1.0"'], versionPattern: 'Janet (\\S+)', ...toolchain };
  r.write('tracks/janet/quest.json', JSON.stringify(quest, null, 2));
}

test('the run key follows the toolchain installed now, and test refuses on a mismatch', { skip: !hasJanet }, (t) => {
  const r = tempRepo({ env: { PATH: `${dirname(janet.stdout.trim())}:${process.env.PATH}` } });
  t.after(r.cleanup);
  withToolchain(r, {});
  r.quest(['start', 'janet/hello-world']);

  // No doctor run needed: the version is observed when the tests run.
  let run = r.quest(['test', 'janet/hello-world']);
  assert.equal(run.code, 0, run.stdout + run.stderr);
  assert.match(run.stdout, /hello-world\s+fail\s+0\/1/);
  assert.equal(JSON.parse(r.read('.cache/results/janet/hello-world.json')).toolVersion, 'fake-1.0');
  assert.match(r.quest(['list']).stdout, /hello-world\s+failing/);

  // The host's tool moves to another version, with no doctor run since: the tests do not run and the
  // result is stale. doctor reports the same.
  withToolchain(r, { versionCommand: ['sh', '-c', 'echo "Janet fake-2.0"'] });
  run = r.quest(['test', 'janet/hello-world']);
  assert.equal(run.code, 1);
  assert.match(run.stdout, /janet fake-2\.0 does not match quest\.json's fake-1\.0/);
  assert.match(r.quest(['list']).stdout, /hello-world\s+stale/);
  const doctor = r.quest(['doctor']);
  assert.equal(doctor.code, 1);
  assert.match(doctor.stderr, /janet fake-2\.0 is installed but quest\.json pins fake-1\.0/);
  assert.equal(JSON.parse(r.read('.cache/doctor.json')).tools.find((x: { source: string }) => x.source === 'toolchain').ok, false);

  // Re-pinning to the new version makes doctor happy again; the old result stays stale until re-run.
  withToolchain(r, { version: 'fake-2.0', versionCommand: ['sh', '-c', 'echo "Janet fake-2.0"'] });
  assert.equal(r.quest(['doctor']).code, 0);
  assert.match(r.quest(['list']).stdout, /hello-world\s+stale/);
  r.quest(['test', 'janet/hello-world']);
  assert.match(r.quest(['list']).stdout, /hello-world\s+failing/);
});

test('a pin change makes a cached pass unusable: done refuses until doctor and test agree again', { skip: !hasJanet }, (t) => {
  const r = tempRepo({ env: { PATH: `${dirname(janet.stdout.trim())}:${process.env.PATH}` } });
  t.after(r.cleanup);
  withToolchain(r, {});
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  assert.equal(r.quest(['doctor']).code, 0);
  assert.match(r.quest(['test', 'janet/hello-world']).stdout, /pass\s+1\/1/);

  // quest.json now pins another version; doctor.json still records the old one as installed.
  withToolchain(r, { version: 'fake-2.0' });
  assert.match(r.quest(['list']).stdout, /hello-world\s+stale/);
  const done = r.quest(['done', 'janet/hello-world', '--yes']);
  assert.notEqual(done.code, 0);
  assert.match(done.stderr, /refusing to mark janet\/hello-world done: janet fake-1\.0 does not match quest\.json's fake-2\.0/);
});

test('a tool removed since doctor ran makes a cached pass unusable, though doctor.json still says ok', { skip: !hasJanet }, (t) => {
  const r = tempRepo({ env: { PATH: `${dirname(janet.stdout.trim())}:${process.env.PATH}` } });
  t.after(r.cleanup);
  withToolchain(r, {});
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  assert.equal(r.quest(['doctor']).code, 0);
  assert.match(r.quest(['test', 'janet/hello-world']).stdout, /pass\s+1\/1/);

  withToolchain(r, { versionCommand: ['quest-no-such-compiler', '--version'] });
  assert.match(r.quest(['list']).stdout, /hello-world\s+stale/);
  const done = r.quest(['done', 'janet/hello-world', '--yes']);
  assert.notEqual(done.code, 0);
  assert.match(done.stderr, /janet not found on this host \(`quest-no-such-compiler --version`\)/);
  assert.match(r.quest(['test', 'janet/hello-world']).stdout, /janet not found on this host/);
});

test('the version is observed with the environment the tests run in', { skip: !hasJanet }, (t) => {
  const r = tempRepo({ env: { PATH: `${dirname(janet.stdout.trim())}:${process.env.PATH}` } });
  t.after(r.cleanup);
  // The version the command reports depends on the environment, as a PATH in test.env would choose
  // another binary; the parent environment says fake-1.0, the tests' says fake-2.0.
  withToolchain(r, { versionCommand: ['sh', '-c', 'echo "Janet ${QUEST_FAKE_JANET:-fake-1.0}"'] });
  const quest = JSON.parse(r.read('tracks/janet/quest.json'));
  quest.test.env = { ...quest.test.env, QUEST_FAKE_JANET: 'fake-2.0' };
  r.write('tracks/janet/quest.json', JSON.stringify(quest, null, 2));
  r.quest(['start', 'janet/hello-world']);
  const run = r.quest(['test', 'janet/hello-world']);
  assert.equal(run.code, 1);
  assert.match(run.stdout, /janet fake-2\.0 does not match quest\.json's fake-1\.0/);
  assert.match(r.quest(['doctor']).stderr, /janet fake-2\.0 is installed but quest\.json pins fake-1\.0/);
});

test('a test command that cannot be started fails quest test without --strict', { skip: !hasJanet }, (t) => {
  const r = tempRepo({ env: { PATH: `${dirname(janet.stdout.trim())}:${process.env.PATH}` } });
  t.after(r.cleanup);
  withToolchain(r, {});
  const quest = JSON.parse(r.read('tracks/janet/quest.json'));
  quest.test.argv = ['quest-no-such-program', '{test}'];
  r.write('tracks/janet/quest.json', JSON.stringify(quest, null, 2));
  r.quest(['start', 'janet/hello-world']);
  assert.equal(r.quest(['doctor']).code, 0);
  const run = r.quest(['test', 'janet/hello-world']);
  assert.equal(run.code, 1);
  assert.match(run.stdout + run.stderr, /could not start quest-no-such-program/);
});

test('doctor names the platforms a toolchain supports when this host is not one of them', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const elsewhere = process.platform === 'freebsd' ? 'linux' : 'freebsd';
  withToolchain(r, { platforms: [elsewhere] });
  const doctor = r.quest(['doctor']);
  assert.equal(doctor.code, 1);
  assert.match(doctor.stderr, new RegExp(`janet: janet is not available on ${process.platform}; it runs on ${elsewhere}`));
});

test('toolchain --install-ci runs every recipe, and is a no-op without one', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  assert.match(r.quest(['toolchain', '--install-ci']).stdout, /nothing to do/);
  withToolchain(r, { ci: { install: [['sh', '-c', 'echo step1 > installed.txt'], ['sh', '-c', 'echo step2 >> installed.txt']] } });
  const out = r.quest(['toolchain', '--install-ci']);
  assert.equal(out.code, 0, out.stderr);
  assert.equal(r.read('installed.txt'), 'step1\nstep2\n');
  withToolchain(r, { ci: { install: [['sh', '-c', 'exit 3']] } });
  assert.equal(r.quest(['toolchain', '--install-ci']).code, 1);
});

const track = (toolchain: Partial<Toolchain> | null) =>
  ({ slug: 'x', quest: { toolchain: toolchain && { bin: 'x', version: '1', versionCommand: ['x'], versionPattern: 'x', ci: { install: [] }, ...toolchain } } }) as unknown as Track;

test('exec wraps argv for mise, host and ci.image tracks', () => {
  const base = { inputDir: '/s/input', mountDir: '/s', timeoutMs: 1000, env: { A: '1' } };
  assert.deepEqual(wrapArgv({ ...base, track: track(null) }, ['janet', 't'], '/s/input', {}), ['mise', 'exec', '--', 'janet', 't']);
  assert.deepEqual(wrapArgv({ ...base, track: track({}) }, ['gforth', 't'], '/s/input', {}), ['gforth', 't']);
  const image = track({ ci: { install: [], image: 'img:1' } });
  assert.deepEqual(wrapArgv({ ...base, track: image, ci: false }, ['inko', 't'], '/s/input', {}), ['inko', 't']);
  assert.deepEqual(wrapArgv({ ...base, track: image, ci: true }, ['inko', 't'], '/s/input', { A: '1' }), [
    'docker', 'run', '--rm', '--user', `${process.getuid!()}:${process.getgid!()}`, '-e', 'HOME=/tmp',
    '-v', '/s:/s', '-w', '/s/input', '-e', 'A=1', 'img:1', 'inko', 't',
  ]);
  assert.deepEqual(wrapArgv({ ...base, track: image, ci: true }, ['inko', 't'], '/s/input', {}, 'quest-1').slice(0, 5), ['docker', 'run', '--rm', '--name', 'quest-1']);
});

const hasDocker = spawnSync('docker', ['info'], { stdio: 'ignore' }).status === 0;

test('ci.image runs the same argv inside a tiny public image with only the staging directory mounted', { skip: !hasDocker && 'docker is not available' }, async (t) => {
  const staging = mkdtempSync(join(tmpdir(), 'quest-image-'));
  t.after(() => rmSync(staging, { recursive: true, force: true }));
  const inputDir = join(staging, 'input');
  mkdirSync(inputDir);
  writeFileSync(join(inputDir, 'file.txt'), 'canonical\n');
  const exec = makeExec({ track: track({ ci: { install: [], image: 'busybox:1.36' } }), inputDir, mountDir: staging, timeoutMs: 120_000, env: { GREETING: 'hi' }, ci: true });
  const r = await exec(['sh', '-c', 'echo "$GREETING from $(pwd)"; cat file.txt']);
  assert.equal(r.exitCode, 0, r.stderr);
  const [greeting, content] = r.stdout.split('\n');
  assert.equal(greeting, `hi from ${inputDir}`);
  assert.equal(content, 'canonical');
});

test('a timed-out ci.image run leaves no container behind', { skip: !hasDocker && 'docker is not available' }, async (t) => {
  const staging = mkdtempSync(join(tmpdir(), 'quest-image-'));
  t.after(() => rmSync(staging, { recursive: true, force: true }));
  const marker = `sleep 7${process.pid % 1000}`;
  const running = () => spawnSync('docker', ['ps', '--no-trunc', '--format', '{{.Command}}'], { encoding: 'utf8' }).stdout.includes(marker);
  const exec = makeExec({ track: track({ ci: { install: [], image: 'busybox:1.36' } }), inputDir: staging, mountDir: staging, timeoutMs: 120_000, env: {}, ci: true });
  // Warm the image first, so the timed run is spent inside the container rather than pulling.
  assert.equal((await exec(['true'])).exitCode, 0);
  const r = await exec(['sh', '-c', marker], { timeoutMs: 3000 });
  assert.equal(r.timedOut, true);
  assert.equal(running(), false, 'the container must be removed, not just the docker CLI killed');
});

test('done names a broken toolchain before a missing result: the toolchain is what to fix first', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  withToolchain(r, { versionCommand: ['quest-no-such-compiler', '--version'] });
  r.quest(['start', 'janet/hello-world']);
  const done = r.quest(['done', 'janet/hello-world', '--yes']);
  assert.equal(done.code, 1);
  assert.match(done.stderr, /refusing to mark janet\/hello-world done: janet not found on this host/);
});
