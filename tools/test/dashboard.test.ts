// buildData() and renderHtml() against a throwaway repo with done commits.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { existsSync, readFileSync } from 'node:fs';
import { request } from 'node:http';
import type { AddressInfo } from 'node:net';
import { join } from 'node:path';
import { exampleOf, repo, tempRepo } from './helpers.ts';
import { fallbackColor } from '../src/core/colors.ts';
import { buildData } from '../src/dashboard/data.ts';
import { directBuildUps, renderHtml } from '../src/dashboard/render.ts';
import { startServer } from '../src/dashboard/server.ts';

function exercise(data: ReturnType<typeof buildData>, slug: string) {
  return data.tracks.find((t) => t.slug === 'janet')!.exercises.find((e) => e.slug === slug)!;
}

test('renders with no .cache and reports never-run workspaces', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', '--unlock', 'janet/leap']);
  r.quest(['start', '--unlock', 'janet/two-fer']);
  assert.ok(!existsSync(join(r.root, '.cache/results')));
  const data = buildData(r.root);
  assert.equal(data.neverRun, 2);
  assert.equal(data.totals.started, 2);
  assert.equal(data.lastRunAt, null);
  const html = renderHtml(data);
  assert.match(html, /<strong>2<\/strong> workspaces have never run on this machine/);
  assert.match(html, /quest test --run-missing/);
});

test('stale marker, date labels and the calendar', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  for (const slug of ['hello-world', 'two-fer']) {
    r.quest(['start', `janet/${slug}`]);
    r.write(`solutions/janet/${slug}/${slug}.janet`, exampleOf('janet', slug));
    r.quest(['test', `janet/${slug}`]);
    assert.equal(r.quest(['done', `janet/${slug}`, '--yes']).code, 0);
  }
  r.quest(['start', '--unlock', 'janet/leap']);
  r.write('solutions/janet/leap/leap.janet', exampleOf('janet', 'leap'));
  r.quest(['test', 'janet/leap']);
  r.git(['add', 'solutions/janet/leap']);
  r.git(['commit', '-qm', 'plain commit, not done']);
  r.quest(['start', '--unlock', 'janet/raindrops']);
  r.quest(['test', 'janet/raindrops']);

  let data = buildData(r.root);
  assert.equal(exercise(data, 'leap').status, 'passing');
  assert.equal(exercise(data, 'leap').date?.kind, 'last-changed');
  assert.equal(exercise(data, 'raindrops').date?.kind, 'uncommitted');
  assert.equal(exercise(data, 'hello-world').date?.kind, 'done');
  assert.equal(exercise(data, 'hello-world').editedSinceDone, false);
  assert.equal(exercise(data, 'raindrops').passed, 0);
  assert.equal(exercise(data, 'raindrops').total, 18);
  const card = data.tracks[0]!;
  const { exercises } = JSON.parse(readFileSync(join(r.root, 'tracks/janet/config.json'), 'utf8'));
  const listed = exercises.concept.length + exercises.practice.length;
  assert.deepEqual([card.done, card.passing, card.listed], [2, 1, listed]);

  let html = renderHtml(data);
  assert.match(html, /<span class="date done"><span class="label">done<\/span> <time>\d{4}-\d\d-\d\d<\/time><\/span>/);
  assert.match(html, /<span class="date last-changed"><span class="label">last changed<\/span>/);
  assert.match(html, /<span class="date uncommitted"[^>]*>uncommitted<\/span>/);
  assert.equal(data.calendar.length, 2);
  // Each track's tiles link to its rows; the in-progress list holds what is under way, not what is done.
  assert.equal((html.match(/<a class="tile s-done"/g) ?? []).length, 2);
  assert.match(html, /<a class="tile s-passing" href="#practice\/janet\/leap"/);
  // A practice exercise's page: the next step for its status, the latest run, its instructions.
  const leap = /<article class="concept exercise" id="ep-janet-leap" hidden>([\s\S]*?)<\/article>/.exec(html)?.[1] ?? '';
  assert.match(leap, /Every test passes: <code>npx quest compare janet\/leap<\/code> shows the example next to yours, and <code>npx quest done janet\/leap<\/code> marks it done\./);
  assert.match(leap, /<h3>Latest run: (\d+)\/\1 passed<\/h3>/);
  assert.match(leap, /<h3>Instructions<\/h3>/);
  assert.match(html, /<tr class="ex[^"]*" id="ex-janet-leap"/);
  const progress = /<h2>In progress<\/h2>(.*?)<\/section>/s.exec(html)![1]!;
  assert.match(progress, /janet\/Leap/);
  assert.match(progress, /janet\/Raindrops/);
  assert.doesNotMatch(progress, /janet\/Hello World/);
  assert.equal((html.match(/<i class="dot"/g) ?? []).length, 2, 'one calendar dot per done commit');

  // A done solution edited since gets a note, and stays done.
  r.write('solutions/janet/two-fer/two-fer.janet', exampleOf('janet', 'two-fer') + '\n# edited\n');
  data = buildData(r.root);
  assert.equal(exercise(data, 'two-fer').status, 'done');
  assert.equal(exercise(data, 'two-fer').editedSinceDone, true);
  assert.match(renderHtml(data), /edited since<\/span>/);
  r.write('solutions/janet/two-fer/two-fer.janet', exampleOf('janet', 'two-fer'));

  // Editing the solution without re-running turns the result stale on the next render.
  r.write('solutions/janet/leap/leap.janet', exampleOf('janet', 'leap') + '\n# edited\n');
  data = buildData(r.root);
  assert.equal(exercise(data, 'leap').status, 'stale');
  html = renderHtml(data);
  assert.match(html, /class="badge s-stale">stale/);
});

test('a passing lesson counts on the overview but not in the Practice pane', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', '--unlock', 'janet/sourdough-schedule']);
  r.write('solutions/janet/sourdough-schedule/sourdough-schedule.janet', readFileSync(join(repo, 'tracks/janet/exercises/concept/sourdough-schedule/.meta/exemplar.janet'), 'utf8'));
  r.quest(['test', 'janet/sourdough-schedule']);
  const html = renderHtml(buildData(r.root));
  assert.match(html, /<td class="tool">1 passing here · /);
  assert.match(html, /<p class="progress"><strong>0<\/strong> of \d+ done · easiest first/);
});

test('--export writes a self-contained page', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const out = r.quest(['dashboard', '--export']);
  assert.equal(out.code, 0, out.stderr);
  const html = readFileSync(join(r.root, 'dashboard/index.html'), 'utf8');
  assert.match(html, /^<!doctype html>/);
  assert.doesNotMatch(html, /<(?:script|link|img)[^>]+(?:src|href)=/i, 'no external requests');
  const json = /<script type="application\/json" id="dashboard-data">(.*?)<\/script>/s.exec(html)![1]!;
  assert.equal(JSON.parse(json).tracks[0].slug, 'janet');
  // The track's colour, from its quest.json, on its overview row and its panes; without one, the palette's by its slug.
  const color = JSON.parse(r.read('tracks/janet/quest.json')).color;
  assert.match(html, new RegExp(`<tr style="--accent:${color}"><td class="name"><a href="#learn/janet"><span class="tmark" aria-hidden="true">Ja</span>`));
  assert.equal((html.match(new RegExp(`<div class="pane" data-track="janet" style="--accent:${color}"`, 'g')) ?? []).length, 2);
  const quest = JSON.parse(r.read('tracks/janet/quest.json'));
  delete quest.color;
  r.write('tracks/janet/quest.json', JSON.stringify(quest, null, 2) + '\n');
  assert.equal(buildData(r.root).tracks[0]!.color, fallbackColor('janet'));
});

test('the server answers a request target that is not a URL with 400 and keeps serving', async (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const server = await startServer(r.root, 0);
  t.after(() => server.close());
  const { port } = server.address() as AddressInfo;
  const get = (path: string) =>
    new Promise<number | undefined>((resolve, reject) => {
      request({ host: '127.0.0.1', port, path, agent: false }, (res) => {
        res.resume();
        resolve(res.statusCode);
      })
        .on('error', reject)
        .end();
    });
  assert.equal(await get('//['), 400);
  assert.equal(await get('/'), 200);
});

test('the server resolves tool versions on every request, so a toolchain change shows without a restart', async (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  // The server runs in this process, which mise must trust with the temporary repository's mise.toml.
  const trusted = process.env.MISE_TRUSTED_CONFIG_PATHS;
  process.env.MISE_TRUSTED_CONFIG_PATHS = r.root;
  t.after(() => (trusted === undefined ? delete process.env.MISE_TRUSTED_CONFIG_PATHS : (process.env.MISE_TRUSTED_CONFIG_PATHS = trusted)));
  const server = await startServer(r.root, 0);
  t.after(() => server.close());
  const { port } = server.address() as AddressInfo;
  const janetVersion = () =>
    new Promise<string | null>((resolve, reject) => {
      request({ host: '127.0.0.1', port, path: '/data.json', agent: false }, (res) => {
        let body = '';
        res.on('data', (chunk) => (body += chunk));
        res.on('end', () => resolve(JSON.parse(body).tracks.find((track: { slug: string }) => track.slug === 'janet').toolVersion));
      })
        .on('error', reject)
        .end();
    });
  assert.equal(await janetVersion(), '1.42.1');
  r.write('mise.toml', r.read('mise.toml').replace(/^janet = "[^"]*"/m, 'janet = "0.0.1"'));
  assert.equal(await janetVersion(), null, 'a pin mise has not installed resolves to no version');
});

test('a request that fails to build its page answers 500, and the server keeps serving', async (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const server = await startServer(r.root, 0);
  t.after(() => server.close());
  const { port } = server.address() as AddressInfo;
  const get = (path: string) =>
    new Promise<{ status: number | undefined; body: string }>((resolve, reject) => {
      request({ host: '127.0.0.1', port, path, agent: false }, (res) => {
        let body = '';
        res.on('data', (chunk) => (body += chunk));
        res.on('end', () => resolve({ status: res.statusCode, body }));
      })
        .on('error', reject)
        .end();
    });
  const quest = r.read('tracks/janet/quest.json');
  r.write('tracks/janet/quest.json', '{ not json');
  for (const path of ['/', '/data.json']) {
    const res = await get(path);
    assert.equal(res.status, 500);
    assert.match(res.body, /^quest dashboard: /);
  }
  r.write('tracks/janet/quest.json', quest);
  assert.equal((await get('/')).status, 200);
});

test("the concept map links a lesson only to the lessons it builds on directly", () => {
  const lesson = (slug: string, after: string[]) => ({ slug, after }) as unknown as Parameters<typeof directBuildUps>[0][number];
  // c names a and b, but b already comes after a; hello-world is not a lesson.
  const links = directBuildUps([lesson('a', ['hello-world']), lesson('b', ['a']), lesson('c', ['a', 'b']), lesson('d', ['a', 'c'])]);
  assert.deepEqual(Object.fromEntries(links), { a: [], b: ['a'], c: ['b'], d: ['c'] });
});
