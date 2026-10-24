// Lessons (Exercism's concept exercises): scaffolded by `quest new --concept`, listed before the practice
// exercises, started with their hints, tested against their exemplar, and validated with prerequisites
// derived from custom.after.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { existsSync, readdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { fixPrerequisites, validateTrack } from '../src/core/validate.ts';
import { exampleOf, tempRepo, type TempRepo } from './helpers.ts';

const LESSON = 'tracks/janet/exercises/concept/lucky-numbers';

/** The temp copy of the Janet track without its own lessons, so each test writes the ones it needs. */
function withoutLessons(r: TempRepo): void {
  const config = JSON.parse(r.read('tracks/janet/config.json'));
  const lessons = new Set(config.exercises.concept.map((e: { slug: string }) => e.slug));
  config.exercises.concept = [];
  config.concepts = [];
  r.write('tracks/janet/config.json', JSON.stringify(config, null, 2) + '\n');
  for (const d of ['exercises/concept', 'concepts']) rmSync(join(r.root, 'tracks/janet', d), { recursive: true, force: true });
  for (const slug of readdirSync(join(r.root, 'tracks/janet/exercises/practice'))) {
    const path = `tracks/janet/exercises/practice/${slug}/.meta/config.json`;
    const meta = JSON.parse(r.read(path));
    const after = (meta.custom?.after ?? []).filter((s: string) => !lessons.has(s));
    if (after.length !== (meta.custom?.after ?? []).length) r.write(path, JSON.stringify({ ...meta, custom: { ...meta.custom, after: after.length ? after : ['hello-world'] } }, null, 2) + '\n');
  }
}

function writeLesson(r: TempRepo): void {
  r.write(`${LESSON}/lucky-numbers.janet`, '(defn lucky\n  "(lucky) -> number"\n  []\n  (error "implement me"))\n');
  r.write(`${LESSON}/.meta/exemplar.janet`, '(defn lucky\n  "(lucky) -> number"\n  []\n  7)\n');
  r.write(`${LESSON}/test/lucky-numbers.janet`, '(import test :as t)\n(import ../lucky-numbers :as sol)\n\n(t/deftest "1. Seven is lucky"\n  (t/assert-equal 7 (sol/lucky)))\n\n(t/run)\n');
  r.write(`${LESSON}/.docs/hints.md`, '# Hints\n\n## 1. Seven is lucky\n\n- Return a number.\n');
}

test('quest new --concept scaffolds a lesson and its concept; the next lesson comes after it', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  withoutLessons(r);
  const out = r.quest(['new', 'janet/lucky-numbers', '--concept', 'basics', '--name', 'Lucky Numbers', '--author', 'tester']);
  assert.equal(out.code, 0, out.stderr);
  assert.match(out.stdout, /created the lesson janet\/lucky-numbers \(basics\)/);
  for (const f of ['.docs/introduction.md', '.docs/instructions.md', '.docs/hints.md', 'lucky-numbers.janet', 'test/lucky-numbers.janet', '.meta/exemplar.janet']) {
    assert.ok(existsSync(join(r.root, LESSON, f)), f);
  }
  for (const f of ['about.md', 'introduction.md', 'links.json', '.meta/config.json']) assert.ok(existsSync(join(r.root, 'tracks/janet/concepts/basics', f)), f);
  const meta = JSON.parse(r.read(`${LESSON}/.meta/config.json`));
  assert.deepEqual(meta.files.exemplar, ['.meta/exemplar.janet']);
  assert.deepEqual(meta.custom, { after: ['hello-world'] });

  assert.equal(r.quest(['new', 'janet/second-lesson', '--concept', 'strings', '--author', 'tester']).code, 0);
  const config = JSON.parse(r.read('tracks/janet/config.json'));
  assert.deepEqual(config.exercises.concept.map((e: { slug: string; prerequisites: string[] }) => [e.slug, e.prerequisites]), [['lucky-numbers', []], ['second-lesson', ['basics']]]);
  assert.deepEqual(config.concepts.map((c: { slug: string }) => c.slug), ['basics', 'strings']);
  assert.equal(config.status.concept_exercises, true);
  assert.deepEqual(JSON.parse(r.read('tracks/janet/exercises/concept/second-lesson/.meta/config.json')).custom, { after: ['lucky-numbers'] });

  // Until it is written, validate says so, file by file.
  const { errors } = validateTrack(join(r.root, 'tracks/janet'), r.root);
  assert.ok(errors.some((e) => /exercises\/concept\/lucky-numbers\/\.docs\/introduction\.md: still holds the scaffold's TODO/.test(e)), errors.join('\n'));
  assert.ok(errors.some((e) => /concepts\/basics\/about\.md: still holds the scaffold's TODO/.test(e)), errors.join('\n'));

  const taken = r.quest(['new', 'janet/third-lesson', '--concept', 'basics', '--author', 'tester']);
  assert.equal(taken.code, 2);
  assert.match(taken.stderr, /--concept: basics is already taught by janet\/lucky-numbers; each concept has one lesson/);
});

test('a lesson is listed first, locked like any exercise, starts with HINTS.md and runs against its exemplar', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  withoutLessons(r);
  r.quest(['new', 'janet/lucky-numbers', '--concept', 'basics', '--name', 'Lucky Numbers', '--author', 'tester']);
  writeLesson(r);

  const list = r.quest(['list', 'janet']).stdout;
  assert.match(list, /^ {2}lucky-numbers\s+locked \(after hello-world\)\s+lesson/m);
  assert.ok(list.indexOf('lucky-numbers') < list.indexOf('hello-world'), 'lessons come first');
  assert.match(r.quest(['test', 'janet/lucky-numbers', '--examples']).stdout, /pass\s+1\/1 passed/);
  assert.match(r.quest(['test', 'janet/lucky-numbers', '--stubs']).stdout, /fails as a stub should/);

  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  r.quest(['test', 'janet/hello-world']);
  assert.equal(r.quest(['done', 'janet/hello-world', '--yes']).code, 0);
  assert.equal(r.quest(['start', 'janet/lucky-numbers']).code, 0);
  assert.match(r.read('solutions/janet/lucky-numbers/HINTS.md'), /## 1\. Seven is lucky/);
  assert.match(r.read('solutions/janet/lucky-numbers/README.md'), /^# Lucky Numbers/);
  assert.match(r.quest(['compare', 'janet/lucky-numbers']).stdout, /exemplar\.janet/);

  // The Learn tab: the concept on the map in its lesson's colour, its page with the lesson and the practice
  // exercises that come after it, and the lesson's row; the Practice tab has no tile for the lesson.
  const meta = JSON.parse(r.read('tracks/janet/exercises/practice/two-fer/.meta/config.json'));
  r.write('tracks/janet/exercises/practice/two-fer/.meta/config.json', JSON.stringify({ ...meta, custom: { after: ['lucky-numbers'] } }, null, 2) + '\n');
  r.write('tracks/janet/concepts/basics/about.md', '# About\n\nValues are `immutable` **by default**.\n');
  r.quest(['dashboard', '--export']);
  const page = r.read('dashboard/index.html');
  assert.match(page, /<span class="group" data-lesson="lucky-numbers" data-builds=""[^>]*><a class="node s-started" id="c-janet-basics" data-concept="basics" href="#learn\/janet\/basics">/);
  const panel = /<article class="concept" id="cp-janet-basics" hidden>([\s\S]*?)<\/article>/.exec(page)?.[1] ?? '';
  assert.match(panel, /Lesson: <a href="#learn\/janet\/lesson\/lucky-numbers"><strong>Lucky Numbers<\/strong><\/a> <span class="badge s-started">started<\/span>/);
  assert.match(panel, /<a href="#practice\/janet\/two-fer">Two-Fer<\/a>/);
  assert.match(panel, /<p>Values are <code>immutable<\/code> <strong>by default<\/strong>\.<\/p>/);
  assert.match(page, /id="ex-janet-lucky-numbers" data-open="#learn\/janet\/lesson\/lucky-numbers">[\s\S]*?<td class="num diff"><span class="none">lesson<\/span><\/td>/);
  assert.doesNotMatch(page, /<a class="tile[^"]*" href="[^"]*lucky-numbers"/);
  // The lesson's own page: what to do next, what it teaches and opens, its hints.
  const lesson = /<article class="concept exercise" id="ep-janet-lucky-numbers" hidden>([\s\S]*?)<\/article>/.exec(page)?.[1] ?? '';
  assert.match(lesson, /Write the solution, then <code>npx quest test janet\/lucky-numbers<\/code>/);
  assert.match(lesson, /Teaches <a href="#learn\/janet\/basics">Basics<\/a>/);
  assert.match(lesson, /Done, it opens<\/h3><ul class="practised"><li><a href="#practice\/janet\/two-fer">Two-Fer<\/a>/);
  assert.match(lesson, /<summary>Hints<\/summary><div class="md"><h4>1\. Seven is lucky<\/h4>/);
});

test('validate derives each lesson\'s prerequisites from custom.after, and --fix writes them', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  withoutLessons(r);
  r.quest(['new', 'janet/lucky-numbers', '--concept', 'basics', '--author', 'tester']);
  r.quest(['new', 'janet/second-lesson', '--concept', 'strings', '--author', 'tester']);
  writeLesson(r);
  const path = 'tracks/janet/exercises/concept/second-lesson/.meta/config.json';
  const meta = JSON.parse(r.read(path));
  meta.custom.after = ['hello-world', 'lucky-numbers', 'two-fer'];
  r.write(path, JSON.stringify(meta, null, 2) + '\n');
  const config = JSON.parse(r.read('tracks/janet/config.json'));
  config.exercises.concept[1].prerequisites = [];
  r.write('tracks/janet/config.json', JSON.stringify(config, null, 2) + '\n');

  const dir = join(r.root, 'tracks/janet');
  const { errors } = validateTrack(dir, r.root);
  assert.ok(errors.some((e) => /exercises\.concept "second-lesson": prerequisites \[\] should be \["basics"\], the concepts its custom\.after teaches; `quest validate --fix` writes them/.test(e)), errors.join('\n'));
  assert.equal(fixPrerequisites(dir, r.root), 1);
  assert.deepEqual(JSON.parse(r.read('tracks/janet/config.json')).exercises.concept[1].prerequisites, ['basics']);
  assert.ok(!validateTrack(dir, r.root).errors.some((e) => e.includes('prerequisites')));
});
