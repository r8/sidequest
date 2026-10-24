// Exercise dependencies: `custom.after` locks an exercise until the exercises it names are done; every
// exercise says it, [] for the ones a track opens with.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { existsSync } from 'node:fs';
import { join } from 'node:path';
import { validateTrack } from '../src/core/validate.ts';
import { exampleOf, tempRepo, type TempRepo } from './helpers.ts';

function setAfter(r: TempRepo, slug: string, after: string[]): void {
  const path = `tracks/janet/exercises/practice/${slug}/.meta/config.json`;
  const config = JSON.parse(r.read(path));
  config.custom = { ...config.custom, after };
  r.write(path, JSON.stringify(config, null, 2) + '\n');
}

function solve(r: TempRepo, slug: string): void {
  r.quest(['start', `janet/${slug}`]);
  r.write(`solutions/janet/${slug}/${slug}.janet`, exampleOf('janet', slug));
  r.quest(['test', `janet/${slug}`]);
  assert.equal(r.quest(['done', `janet/${slug}`, '--yes']).code, 0);
}

test('an exercise is locked until its after is done; start refuses it unless --unlock', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  setAfter(r, 'leap', ['two-fer']);
  setAfter(r, 'raindrops', ['two-fer']);
  setAfter(r, 'hamming', []);

  // The track opens with hello-world, and whatever else says [].
  let list = r.quest(['list', 'janet']).stdout;
  assert.match(list, /hello-world\s+available/);
  assert.match(list, /hamming\s+available/);
  assert.match(list, /two-fer\s+locked \(after hello-world\)/);
  assert.match(list, /leap\s+locked \(after two-fer\)/);
  const refused = r.quest(['start', 'janet/leap']);
  assert.equal(refused.code, 1);
  assert.match(refused.stderr, /janet\/leap is locked until janet\/two-fer is done; `quest start --unlock janet\/leap` starts it anyway/);
  assert.equal(existsSync(join(r.root, 'solutions/janet/leap')), false);

  // Unlocked, it is started like any other, and a workspace is never locked again.
  assert.equal(r.quest(['start', '--unlock', 'janet/leap']).code, 0);
  assert.match(r.quest(['list', 'janet']).stdout, /leap\s+started/);
  assert.equal(r.quest(['start', '--refresh-tests', 'janet/leap']).code, 0);

  r.quest(['dashboard', '--export']);
  const page = r.read('dashboard/index.html');
  assert.match(page, /class="tile s-locked"[^>]*title="Raindrops · locked · difficulty \d+ · after two-fer"/);
  assert.match(page, /<tr class="ex locked" id="ex-janet-raindrops" data-open="#practice\/janet\/raindrops">[\s\S]*?<svg class="lock"[\s\S]*?locked<\/span> <span class="after">after two-fer<\/span>/);

  solve(r, 'hello-world');
  list = r.quest(['list', 'janet']).stdout;
  assert.match(list, /two-fer\s+available/);
  assert.match(list, /raindrops\s+locked \(after two-fer\)/);
  solve(r, 'two-fer');
  assert.match(r.quest(['list', 'janet']).stdout, /raindrops\s+available/);
  assert.equal(r.quest(['start', 'janet/raindrops']).code, 0);
});

test('validate rejects a missing after, and one that names no exercise, itself, twice, or closes a cycle', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const path = 'tracks/janet/exercises/practice/bob/.meta/config.json';
  const bob = JSON.parse(r.read(path));
  delete bob.custom;
  r.write(path, JSON.stringify(bob, null, 2) + '\n');
  setAfter(r, 'hello-world', ['no-such-exercise']);
  setAfter(r, 'two-fer', ['two-fer']);
  setAfter(r, 'hamming', ['leap', 'leap']);
  setAfter(r, 'leap', ['raindrops']);
  setAfter(r, 'raindrops', ['leap']);
  const { errors } = validateTrack(join(r.root, 'tracks/janet'), r.root);
  const has = (re: RegExp) => assert.ok(errors.some((e) => re.test(e)), `${re}\n${errors.join('\n')}`);
  has(/bob\/\.meta\/config\.json: custom\.after: missing; \[\] opens the exercise from the start, \["hello-world"\] after hello-world/);
  has(/hello-world\/\.meta\/config\.json: custom\.after: "no-such-exercise" is not an exercise of the track/);
  has(/two-fer\/\.meta\/config\.json: custom\.after: an exercise cannot come after itself/);
  has(/hamming\/\.meta\/config\.json: custom\.after: "leap" is listed twice/);
  assert.equal(errors.filter((e) => e.includes('a cycle')).length, 1, errors.join('\n'));
  has(/custom\.after: a cycle locks these for good: (leap → raindrops → leap|raindrops → leap → raindrops)/);
});
