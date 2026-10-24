// quest new, quest new-track, cache prune and orphans. The first two need
// configlet (and network for problem-specifications); they are skipped without mise.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { existsSync, readdirSync, readFileSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { tempRepo } from './helpers.ts';
import { filterCanonical, todoSkeleton } from '../src/core/authoring.ts';
import { PALETTE } from '../src/core/colors.ts';
import type { CanonicalData } from '../src/schema/canonical.ts';

const hasMise = spawnSync('sh', ['-c', 'command -v mise']).status === 0;
const configlet = (root: string, args: string[]) =>
  spawnSync('mise', ['exec', '--', 'configlet', ...args], { cwd: root, env: { ...process.env, MISE_TRUSTED_CONFIG_PATHS: root }, encoding: 'utf8' });

test('quest new yields an exercise configlet lint and sync accept, with the attribution', { skip: !hasMise }, (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  // Start from a track without hamming.
  rmSync(join(r.root, 'tracks/janet/exercises/practice/hamming'), { recursive: true });
  const config = JSON.parse(r.read('tracks/janet/config.json'));
  config.exercises.practice = config.exercises.practice.filter((e: { slug: string }) => e.slug !== 'hamming');
  r.write('tracks/janet/config.json', JSON.stringify(config, null, 2) + '\n');

  const out = r.quest(['new', 'janet/hamming', '--author', 'tester', '--difficulty', '2']);
  assert.equal(out.code, 0, out.stderr);
  const dir = join(r.root, 'tracks/janet/exercises/practice/hamming');
  assert.match(readFileSync(join(dir, '.docs/instructions.append.md'), 'utf8'), /problem-specifications.*MIT License/);
  assert.equal(configlet(r.root, ['lint', '-t', join(r.root, 'tracks/janet')]).status, 0);
  const sync = configlet(r.root, ['sync', '-o', '-t', join(r.root, 'tracks/janet')]);
  assert.equal(sync.status, 0, sync.stdout);
  assert.ok(JSON.parse(r.read('tracks/janet/config.json')).exercises.practice.some((e: { slug: string }) => e.slug === 'hamming'));
  assert.ok(existsSync(join(dir, 'test/hamming.janet')));
  assert.deepEqual(JSON.parse(readFileSync(join(dir, '.meta/config.json'), 'utf8')).custom, { after: ['hello-world'] });
});

test('quest new janet/isogram generates tests that pass against the example unedited', { skip: !hasMise }, (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const dir = join(r.root, 'tracks/janet/exercises/practice/isogram');
  const example = readFileSync(join(dir, '.meta/example.janet'), 'utf8');
  rmSync(dir, { recursive: true });
  const config = JSON.parse(r.read('tracks/janet/config.json'));
  config.exercises.practice = config.exercises.practice.filter((e: { slug: string }) => e.slug !== 'isogram');
  r.write('tracks/janet/config.json', JSON.stringify(config, null, 2) + '\n');

  assert.match(r.quest(['new', 'janet/isogram', '--author', 'tester', '--after', 'no-such']).stderr, /--after: no-such is not an exercise of janet/);
  const out = r.quest(['new', 'janet/isogram', '--author', 'tester', '--after', 'leap,two-fer']);
  assert.equal(out.code, 0, out.stderr);
  assert.match(out.stdout, /review the generated tests/);
  assert.deepEqual(JSON.parse(readFileSync(join(dir, '.meta/config.json'), 'utf8')).custom, { after: ['leap', 'two-fer'] });
  r.write('tracks/janet/exercises/practice/isogram/.meta/example.janet', example);
  const run = r.quest(['test', 'janet/isogram', '--examples']);
  assert.equal(run.code, 0, run.stdout + run.stderr);
  assert.match(run.stdout, /pass\s+14\/14 passed/);
});

test('quest new-track yields a track that lints clean with hello-world only', { skip: !hasMise }, (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const out = r.quest(['new-track', 'fixture', '--language', 'Fixture', '--author', 'tester']);
  assert.equal(out.code, 0, out.stderr);
  const lint = configlet(r.root, ['lint', '-t', join(r.root, 'tracks/fixture')]);
  assert.equal(lint.status, 0, lint.stdout);
  const config = JSON.parse(r.read('tracks/fixture/config.json'));
  assert.deepEqual(config.exercises.practice.map((e: { slug: string }) => e.slug), ['hello-world']);
  assert.equal(JSON.parse(r.read('tracks/fixture/quest.json')).runner, 'fixture');
  assert.match(r.read('tracks/fixture/exercises/practice/hello-world/.docs/instructions.append.md'), /problem-specifications\/tree\/main\/exercises\/hello-world\), Copyright/);
  assert.deepEqual(JSON.parse(r.read('tracks/fixture/exercises/practice/hello-world/.meta/config.json')).custom, { after: [] });
  // A colour of its own, written down so it can be changed.
  const used: string[] = readdirSync(join(r.root, 'tracks')).filter((d) => d !== 'fixture').map((d) => JSON.parse(r.read(`tracks/${d}/quest.json`)).color);
  const color: string = JSON.parse(r.read('tracks/fixture/quest.json')).color;
  assert.ok(PALETTE.includes(color) && !used.includes(color), `${color} after ${used}`);
  assert.equal(color, PALETTE.find((c) => !used.includes(c)));
  assert.match(out.stdout, new RegExp(`in ${color} on the dashboard \\(colour ${PALETTE.indexOf(color) + 1} of 18;`));
});

test('quest new-track refuses a --color that is not #rrggbb', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const out = r.quest(['new-track', 'fixture', '--language', 'Fixture', '--color', 'purple']);
  assert.equal(out.code, 2);
  assert.match(out.stderr, /--color must be a #rrggbb colour/);
  assert.ok(!existsSync(join(r.root, 'tracks/fixture')));
});

test('cache prune deletes results for unlisted slugs; such a workspace is an orphan', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', '--unlock', 'janet/leap']);
  r.quest(['start', 'janet/hello-world']);
  r.quest(['test', 'janet']);
  const config = JSON.parse(r.read('tracks/janet/config.json'));
  config.exercises.practice = config.exercises.practice.filter((e: { slug: string }) => e.slug !== 'leap');
  r.write('tracks/janet/config.json', JSON.stringify(config, null, 2) + '\n');
  assert.match(r.quest(['list', 'janet']).stdout, /leap\s+orphan/);
  const prune = r.quest(['cache', 'prune']);
  assert.match(prune.stdout, /pruned \.cache\/results\/janet\/leap\.json/);
  assert.ok(!existsSync(join(r.root, '.cache/results/janet/leap.json')));
  assert.ok(existsSync(join(r.root, '.cache/results/janet/hello-world.json')));
});

test('filterCanonical honours include = false and reimplements', () => {
  const data: CanonicalData = {
    exercise: 'x',
    cases: [
      { description: 'group', cases: [
        { uuid: 'a', description: 'old', property: 'p', input: {}, expected: 1 },
        { uuid: 'b', description: 'new', property: 'p', input: {}, expected: 2, reimplements: 'a' },
      ] },
      { uuid: 'c', description: 'excluded', property: 'p', input: {}, expected: 3 },
    ],
  };
  const kept = filterCanonical(data, { included: new Set(['a', 'b']), excluded: new Set(['c']) });
  assert.match(todoSkeleton(kept, 'x', ';'), /^; TODO group > new \[b\]$/m);
  assert.doesNotMatch(todoSkeleton(kept, 'x', ';'), /\[a\]|\[c\]/);
});
