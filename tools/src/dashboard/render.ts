// renderHtml(): DashboardData → one self-contained page. Inline CSS and JS, no external requests,
// so the exported file opens from file://.
import { STATUSES, type DashboardConcept, type DashboardData, type DashboardExercise, type DashboardTrack } from '../schema/dashboard.ts';
import { markdown } from './markdown.ts';

const esc = (s: string) => s.replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]!);

function dateCell(e: DashboardExercise): string {
  if (!e.date) return '<span class="date none">—</span>';
  if (e.date.kind === 'uncommitted') return '<span class="date uncommitted" title="git has never seen the solution">uncommitted</span>';
  const label = e.date.kind === 'done' ? 'done' : 'last changed';
  return `<span class="date ${e.date.kind}"><span class="label">${label}</span> <time>${esc(e.date.value ?? '')}</time></span>`;
}

const LOCK = '<svg class="lock" viewBox="0 0 10 12" width="8" height="10" aria-hidden="true"><rect x="1" y="5" width="8" height="6.5" rx="1.2" fill="currentColor"/><path d="M3 5V3.6a2 2 0 0 1 4 0V5" fill="none" stroke="currentColor" stroke-width="1.4"/></svg>';

function badges(e: DashboardExercise): string {
  let out = `<span class="badge s-${e.status}">${e.status === 'locked' ? LOCK : ''}${e.status}</span>`;
  if (e.waitingOn.length) out += ` <span class="after">after ${esc(e.waitingOn.join(', '))}</span>`;
  if (e.cacheStatus === 'stale' && e.status !== 'stale') out += ' <span class="badge stale-mark" title="the solution, tests, harness or toolchain changed since this result">stale</span>';
  if (e.status === 'done' && e.cacheStatus === 'failing') out += ' <span class="badge s-failing" title="done, but failing on this machine">failing here</span>';
  if (e.editedSinceDone) out += ' <span class="badge stale-mark" title="the solution has changed since it was marked done">edited since</span>';
  return out;
}

function details(e: DashboardExercise): string {
  if (!e.tests.length && !e.message) return '';
  const rows = e.tests
    .map((t) => `<li class="t-${t.status}"><span class="mark">${t.status === 'pass' ? '✓' : t.status === 'fail' ? '✗' : '!'}</span> ${esc(t.name)}${t.message ? `<pre>${esc(t.message)}</pre>` : ''}</li>`)
    .join('');
  return `<div class="details">${e.message ? `<pre class="message">${esc(e.message)}</pre>` : ''}${rows ? `<ul>${rows}</ul>` : ''}${e.ranAt ? `<p class="ran">ran ${esc(e.ranAt)}</p>` : ''}</div>`;
}

/** A track's colour, for the element and everything in it. */
const accent = (color: string) => ` style="--accent:${esc(color)}"`;
/** A track's mark: its colour, with the language's first letters. */
const trackMark = (t: DashboardTrack) => `<span class="tmark" aria-hidden="true">${esc(t.language.slice(0, 2))}</span>`;

/** The element id of an exercise's row in its track's table. */
const rowId = (track: string, slug: string) => `ex-${track}-${slug}`.replace(/[^A-Za-z0-9_-]/g, '-');
/** The element id of an exercise's page, and the hash that opens it: a lesson's in Learn, the rest in Practice. */
const pageId = (track: string, slug: string) => `ep-${track}-${slug}`.replace(/[^A-Za-z0-9_-]/g, '-');
const pageHref = (track: string, e: DashboardExercise) => (e.kind === 'concept' ? `#learn/${track}/lesson/${e.slug}` : `#practice/${track}/${e.slug}`);

/** A table row that opens the exercise's page; `color` is its track's, where the rows mix tracks. */
function exerciseRows(track: string, e: DashboardExercise, id: string | null = null, label = e.name, color: string | null = null): string {
  const tests = e.total === null ? '<span class="none">—</span>' : `${e.passed}/${e.total}`;
  const href = pageHref(track, e);
  return `<tr class="ex${e.status === 'locked' ? ' locked' : ''}"${id ? ` id="${id}"` : ''}${color ? accent(color) : ''} data-open="${href}">
<td class="name"><a href="${href}">${esc(label)}</a></td>
<td class="num diff">${e.kind === 'concept' ? '<span class="none">lesson</span>' : (e.difficulty ?? '')}</td><td>${badges(e)}</td><td>${dateCell(e)}</td><td class="num">${tests}</td></tr>`;
}

/** What to do next with an exercise, by its status. */
function nextStep(track: string, e: DashboardExercise, all: DashboardExercise[]): string {
  const ref = `${esc(track)}/${esc(e.slug)}`;
  const cmd = (c: string) => `<code>npx quest ${c} ${ref}</code>`;
  switch (e.status) {
    case 'locked': {
      const waits = e.waitingOn.map((s) => {
        const w = all.find((x) => x.slug === s);
        return w ? `<a href="${pageHref(track, w)}">${esc(w.name)}</a>` : esc(s);
      });
      return `Locked until ${waits.join(', ')} ${waits.length > 1 ? 'are' : 'is'} done; <code>npx quest start --unlock ${ref}</code> starts it anyway.`;
    }
    case 'available':
      return `${cmd('start')} puts the stub, the tests and these instructions in <code>solutions/${ref}/</code>.`;
    case 'started':
      return `Write the solution, then ${cmd('test')}.`;
    case 'failing':
      return `${cmd('test')} after each change; the latest run is below.`;
    case 'stale':
      return `The solution, the tests or the toolchain changed since the last run: ${cmd('test')}.`;
    case 'passing':
      return `Every test passes: ${cmd('compare')} shows the example next to yours, and ${cmd('done')} marks it done.`;
    case 'done':
      return `Done${e.cacheStatus === 'failing' ? ', but failing on this machine' : ''}. ${cmd('compare')} shows the example next to yours.`;
    default:
      return '';
  }
}

/** An exercise's page: what to do next, the latest run, what it opens, its instructions and hints. */
function exercisePanel(t: DashboardTrack, e: DashboardExercise): string {
  const tab = e.kind === 'concept' ? 'learn' : 'practice';
  const opens = t.exercises.filter((x) => x.after.includes(e.slug));
  const teaches = t.concepts.filter((c) => c.lesson === e.slug);
  const run = details(e);
  return `<article class="concept exercise" id="${pageId(t.slug, e.slug)}" hidden>
<header><h2>${esc(e.name)}</h2><a class="close" href="#${tab}/${t.slug}" aria-label="close">×</a></header>
${e.blurb ? `<p class="blurb">${esc(e.blurb)}</p>` : ''}
<p class="lesson">${e.kind === 'concept' ? '<span class="none">lesson</span>' : e.difficulty === null ? '' : `<span class="none">difficulty ${e.difficulty}</span>`} ${badges(e)} ${e.date ? dateCell(e) : ''}</p>
<p class="next">${nextStep(t.slug, e, t.exercises)}</p>
${teaches.length ? `<p>Teaches ${teaches.map((c) => `<a href="#learn/${t.slug}/${c.slug}">${esc(c.name)}</a>`).join(', ')}.</p>` : ''}
${opens.length ? `<h3>Done, it opens</h3><ul class="practised">${opens.map((x) => `<li><a href="${pageHref(t.slug, x)}">${esc(x.name)}</a> ${badges(x)}</li>`).join('')}</ul>` : ''}
${run ? `<h3>Latest run${e.total === null ? '' : `: ${e.passed}/${e.total} passed`}</h3>${run}` : ''}
<div class="md">${markdown(e.instructions, 2)}</div>
${e.hints ? `<details class="all hints"><summary>Hints</summary><div class="md">${markdown(e.hints.replace(/^# [^\n]*\n+/, ''), 2)}</div></details>` : ''}
${e.source ? `<p class="ran">Based on ${e.source.url ? `<a href="${esc(e.source.url)}" target="_blank" rel="noopener">${esc(e.source.text)}</a>` : esc(e.source.text)}</p>` : ''}</article>`;
}

const TABLE_HEAD = '<thead><tr><th>Exercise</th><th class="num diff">Diff.</th><th>Status</th><th>Date</th><th class="num">Tests</th></tr></thead>';

/** One tile per practice exercise, easiest first, coloured by status; a tile opens the exercise's page. */
function tiles(t: DashboardTrack, list: DashboardExercise[]): string {
  const order = list.map((e, i) => ({ e, i })).sort((a, b) => (a.e.difficulty ?? 99) - (b.e.difficulty ?? 99) || a.i - b.i);
  return `<div class="tiles">${order
    .map(({ e }) => {
      const notes = [e.status, e.difficulty === null ? '' : `difficulty ${e.difficulty}`, e.cacheStatus === 'failing' && e.status === 'done' ? 'failing here' : '', e.editedSinceDone ? 'edited since' : '', e.waitingOn.length ? `after ${e.waitingOn.join(', ')}` : ''].filter(Boolean);
      return `<a class="tile s-${e.status}" href="${pageHref(t.slug, e)}" data-slug="${esc(e.slug)}" title="${esc(`${e.name} · ${notes.join(' · ')}`)}"></a>`;
    })
    .join('')}</div>`;
}

const lessonsOf = (t: DashboardTrack) => t.exercises.filter((e) => e.kind === 'concept');
const practiceOf = (t: DashboardTrack) => t.exercises.filter((e) => e.kind === 'practice');
const doneOf = (list: DashboardExercise[]) => list.filter((e) => e.status === 'done').length;
const passingOf = (list: DashboardExercise[]) => list.filter((e) => e.status === 'passing').length;

function bar(done: number, total: number): string {
  return `<span class="bar" title="${done} of ${total} done"><i style="width:${total ? (100 * done) / total : 0}%"></i></span>`;
}

/** Every track at a glance: its lessons and practice exercises done, each opening its tab. */
function tracksOverview(data: DashboardData): string {
  const rows = data.tracks.map((t) => {
    if (!t.listed) return `<tr${accent(t.color)}><td class="name">${trackMark(t)}${esc(t.language)}</td><td colspan="3" class="none">${t.exercises.length} workspace(s)</td></tr>`;
    const lessons = lessonsOf(t);
    const practice = practiceOf(t);
    const cell = (tab: string, list: DashboardExercise[]) =>
      list.length ? `<a class="count" href="#${tab}/${t.slug}">${bar(doneOf(list), list.length)}<span><strong>${doneOf(list)}</strong> of ${list.length}</span></a>` : '<span class="none">—</span>';
    return `<tr${accent(t.color)}><td class="name"><a href="#learn/${t.slug}">${trackMark(t)}<strong>${esc(t.language)}</strong></a> <span class="slug">${esc(t.slug)}</span></td>
<td>${cell('learn', lessons)}</td><td>${cell('practice', practice)}</td>
<td class="tool">${t.passing ? `${t.passing} passing here · ` : ''}${t.toolVersion ? `toolchain ${esc(t.toolVersion)}` : 'toolchain unresolved'}</td></tr>`;
  });
  return `<section class="card"><header><h2>Tracks</h2><span class="tool">lessons in Learn, the rest in Practice</span></header>
<table class="overview"><thead><tr><th>Track</th><th>Lessons</th><th>Practice</th><th></th></tr></thead><tbody>${rows.join('')}</tbody></table></section>`;
}

/** A track's practice exercises: tiles easiest first, then the table they open. */
function practicePane(t: DashboardTrack): string {
  const list = practiceOf(t);
  const passing = passingOf(list);
  return `<div class="pane" data-track="${esc(t.slug)}"${accent(t.color)} hidden>
<p class="progress"><strong>${doneOf(list)}</strong> of ${list.length} done${passing ? ` · ${passing} passing here` : ''} · easiest first · click a tile or a row for its page</p>
${tiles(t, list)}
${list.map((e) => exercisePanel(t, e)).join('\n')}
<table>${TABLE_HEAD}<tbody>${list.map((e) => exerciseRows(t.slug, e, rowId(t.slug, e.slug))).join('')}</tbody></table></div>`;
}

const conceptId = (track: string, slug: string) => `${track}-${slug}`.replace(/[^A-Za-z0-9_-]/g, '-');

/** One concept's page: its explanation, the lesson that teaches it, and the practice exercises after that lesson. */
function conceptPanel(t: DashboardTrack, c: DashboardConcept): string {
  const lesson = t.exercises.find((e) => e.slug === c.lesson);
  const practice = c.lesson ? practiceOf(t).filter((e) => e.after.includes(c.lesson!)) : [];
  const links = c.links.length ? `<h3>Links</h3><ul class="links">${c.links.map((l) => `<li><a href="${esc(l.url)}" target="_blank" rel="noopener">${esc(l.description)}</a></li>`).join('')}</ul>` : '';
  const lessonLine = lesson
    ? `<p class="lesson">Lesson: <a href="${pageHref(t.slug, lesson)}"><strong>${esc(lesson.name)}</strong></a> ${badges(lesson)} <code>npx quest start ${esc(t.slug)}/${esc(lesson.slug)}</code></p>`
    : '';
  const practised = practice.length
    ? `<h3>Practice after this lesson</h3><ul class="practised">${practice.map((e) => `<li><a href="#practice/${t.slug}/${e.slug}">${esc(e.name)}</a> ${badges(e)}</li>`).join('')}</ul>`
    : '';
  return `<article class="concept" id="cp-${conceptId(t.slug, c.slug)}" hidden>
<header><h2>${esc(c.name)}</h2><a class="close" href="#learn/${t.slug}" aria-label="close">×</a></header>
${c.blurb ? `<p class="blurb">${esc(c.blurb)}</p>` : ''}${lessonLine}${practised}
<div class="md">${markdown(c.about.replace(/^# [^\n]*\n+/, ''), 2)}</div>${links}</article>`;
}

/**
 * Each lesson's links to the lessons it comes after, less those implied through another of them, so the
 * map draws a lesson's direct build-ups only.
 */
export function directBuildUps(lessons: DashboardExercise[]): Map<string, string[]> {
  const slugs = new Set(lessons.map((e) => e.slug));
  const before = new Map(lessons.map((e) => [e.slug, e.after.filter((s) => slugs.has(s))]));
  const reach = (from: string, seen = new Set<string>()): Set<string> => {
    for (const s of before.get(from) ?? []) if (!seen.has(s)) (seen.add(s), reach(s, seen));
    return seen;
  };
  return new Map([...before].map(([slug, deps]) => [slug, deps.filter((d) => !deps.some((o) => o !== d && reach(o).has(d)))]));
}

/** A track's syllabus as a concept map: a row per depth, each lesson's concepts together, coloured by its status. */
function learnPane(t: DashboardTrack): string {
  const lessons = lessonsOf(t);
  if (!t.concepts.length) return `<div class="pane" data-track="${esc(t.slug)}"${accent(t.color)} hidden><p class="empty">${esc(t.language)} has no lessons yet — <code>quest new ${esc(t.slug)}/&lt;slug&gt; --concept &lt;concept&gt;</code> writes one.</p></div>`;
  const status = new Map(lessons.map((e) => [e.slug, e]));
  const builds = directBuildUps(lessons);
  const levels: DashboardConcept[][][] = [];
  for (const c of t.concepts) {
    const row = (levels[c.level] ??= []);
    const group = row.find((g) => g[0]!.lesson === c.lesson);
    if (group) group.push(c);
    else row.push([c]);
  }
  // Row by row, each lesson under the middle of the lessons it builds on, so fewer links cross.
  const at = new Map<string, number>();
  for (const row of levels.filter(Boolean)) {
    const key = (g: DashboardConcept[]) => {
      const xs = (builds.get(g[0]!.lesson ?? '') ?? []).map((s) => at.get(s)).filter((x): x is number => x !== undefined);
      return xs.length ? xs.reduce((a, b) => a + b, 0) / xs.length : 0.5;
    };
    row.sort((a, b) => key(a) - key(b));
    row.forEach((g, i) => at.set(g[0]!.lesson ?? '', (i + 0.5) / row.length));
  }
  const node = (c: DashboardConcept, e: DashboardExercise | undefined) =>
    `<a class="node s-${e?.status ?? 'available'}" id="c-${conceptId(t.slug, c.slug)}" data-concept="${esc(c.slug)}" href="#learn/${t.slug}/${c.slug}">${e?.status === 'locked' ? LOCK : '<i></i>'}${esc(c.name)}</a>`;
  const group = (g: DashboardConcept[]) => {
    const lesson = g[0]!.lesson ?? '';
    const e = status.get(lesson);
    const title = [e ? `lesson ${e.name}` : '', e?.status ?? '', e?.waitingOn.length ? `after ${e.waitingOn.join(', ')}` : ''].filter(Boolean).join(' · ');
    return `<span class="group" data-lesson="${esc(lesson)}" data-builds="${esc((builds.get(lesson) ?? []).join(' '))}" title="${esc(title)}">${g.map((c) => node(c, e)).join('')}</span>`;
  };
  return `<div class="pane" data-track="${esc(t.slug)}"${accent(t.color)} hidden>
<p class="progress"><strong>${doneOf(lessons)}</strong> of ${lessons.length} lessons done · ${t.concepts.length} concepts · a lesson's concepts sit together · click a concept for its page</p>
<div class="map"><svg class="edges" aria-hidden="true"></svg>${levels.filter(Boolean).map((row) => `<div class="level">${row.map(group).join('')}</div>`).join('')}</div>
${t.concepts.map((c) => conceptPanel(t, c)).join('\n')}
${lessons.map((e) => exercisePanel(t, e)).join('\n')}
<details class="all"><summary>All ${lessons.length} lessons</summary>
<table>${TABLE_HEAD}<tbody>${lessons.map((e) => exerciseRows(t.slug, e, rowId(t.slug, e.slug))).join('')}</tbody></table></details></div>`;
}

/** The tracks to choose from in the Learn and Practice tabs. */
function picker(data: DashboardData, tab: string): string {
  return `<nav class="picker">${data.tracks.filter((t) => t.listed).map((t) => `<a href="#${tab}/${t.slug}" data-track="${esc(t.slug)}"${accent(t.color)}><i></i>${esc(t.language)}</a>`).join('')}</nav>`;
}

const SHOWN = 8;

// What needs attention first, then what is under way.
const ATTENTION: Record<string, number> = { failing: 0, stale: 1, 'done-failing': 2, started: 3, passing: 4, 'done-edited': 5 };

function attention(e: DashboardExercise): string | null {
  if (e.status === 'done') return e.cacheStatus === 'failing' ? 'done-failing' : e.editedSinceDone ? 'done-edited' : null;
  return e.status in ATTENTION ? e.status : null;
}

/** Every exercise under way or needing attention, across tracks. */
function inProgress(data: DashboardData): string {
  const rows = data.tracks
    .flatMap((t) => t.exercises.map((e) => ({ t, e, why: attention(e) })))
    .filter((r): r is typeof r & { why: string } => r.why !== null)
    .sort((a, b) => ATTENTION[a.why]! - ATTENTION[b.why]! || (b.e.date?.value ?? '').localeCompare(a.e.date?.value ?? ''));
  const table = (list: typeof rows) => `<table>${TABLE_HEAD}<tbody>${list.map(({ t, e }) => exerciseRows(t.slug, e, null, `${t.slug}/${e.name}`, t.color)).join('')}</tbody></table>`;
  const more = rows.length > SHOWN ? `<details class="all"><summary>${rows.length - SHOWN} more</summary>${table(rows.slice(SHOWN))}</details>` : '';
  const body = rows.length
    ? table(rows.slice(0, SHOWN)) + more
    : '<p class="empty">Nothing in progress — <code>quest start &lt;track&gt;/hello-world</code> opens a track.</p>';
  return `<section class="card"><header><h2>In progress</h2><span class="tool">${rows.length || ''}</span></header>${body}</section>`;
}

function calendar(data: DashboardData): string {
  const byDate = new Map<string, string[]>();
  const colors = new Map(data.tracks.map((t) => [t.slug, t.color]));
  for (const c of data.calendar) byDate.set(c.date, [...(byDate.get(c.date) ?? []), c.exercise]);
  const now = new Date(data.generatedAt);
  const first = data.calendar.length ? new Date(`${data.calendar[0]!.date}T00:00:00Z`) : now;
  const months: { y: number; m: number }[] = [];
  for (let y = first.getUTCFullYear(), m = first.getUTCMonth(); y < now.getUTCFullYear() || (y === now.getUTCFullYear() && m <= now.getUTCMonth()); m === 11 ? (y++, (m = 0)) : m++) {
    months.push({ y, m });
  }
  const shown = months.slice(-3);
  const grids = shown.map(({ y, m }) => {
    const days = new Date(Date.UTC(y, m + 1, 0)).getUTCDate();
    const lead = (new Date(Date.UTC(y, m, 1)).getUTCDay() + 6) % 7; // Monday first
    const cells = Array.from({ length: lead }, () => '<span class="day pad"></span>');
    for (let d = 1; d <= days; d++) {
      const iso = `${y}-${String(m + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
      const done = byDate.get(iso) ?? [];
      const dots = done.map((ex) => `<i class="dot" title="${esc(ex)}"${colors.has(ex.split('/')[0]!) ? ` style="background:${esc(colors.get(ex.split('/')[0]!)!)}"` : ''}></i>`).join('');
      cells.push(`<span class="day${done.length ? ' hit' : ''}" title="${iso}${done.length ? `: ${esc(done.join(', '))}` : ''}"><b>${d}</b>${dots}</span>`);
    }
    const name = new Date(Date.UTC(y, m, 1)).toLocaleString('en', { month: 'long', year: 'numeric', timeZone: 'UTC' });
    return `<div class="month"><h3>${name}</h3><div class="grid">${['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((w) => `<span class="wd">${w}</span>`).join('')}${cells.join('')}</div></div>`;
  });
  return `<section class="card calendar"><header><h2>Completions</h2><span class="tool">${data.calendar.length} done</span></header>
${data.calendar.length ? '' : '<p class="empty">Nothing done yet — <code>quest done &lt;track&gt;/&lt;slug&gt;</code> marks a passing solution done.</p>'}<div class="months">${grids.join('')}</div></section>`;
}

const CSS = `
:root{--bg:#f6f5fa;--card:#fff;--fg:#1d1d1f;--muted:#6b6b70;--line:#e6e4ee;--done:#1f8a4c;--passing:#2a9d8f;--failing:#c8372d;--stale:#b7791f;--started:#3b6fb6;--locked:#a8a8ae;--orphan:#7c4dbd;--code:#f2f1f6;--brand:#6d4aff;--accent:var(--brand)}
@media (prefers-color-scheme:dark){:root{--bg:#131318;--card:#1c1c22;--fg:#ececef;--muted:#9a9aa2;--line:#2e2d36;--done:#3fbf74;--passing:#45c1b2;--failing:#f0675c;--stale:#e0a640;--started:#6b9be0;--locked:#5a5a62;--orphan:#a883e6;--code:#26252d;--brand:#9b86ff}}
/* --accent is the track's colour inside its rows and panes (the brand colour elsewhere); these follow it. */
:root,[style*="--accent"]{--available:var(--accent);--ink:color-mix(in srgb,var(--accent) 72%,var(--fg));--tint:color-mix(in srgb,var(--accent) 13%,var(--card));--soft:color-mix(in srgb,var(--accent) 38%,var(--line));--hatch:color-mix(in srgb,var(--accent) 50%,var(--locked))}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--fg);font:14px/1.45 ui-sans-serif,system-ui,-apple-system,"Segoe UI",sans-serif}
main{max-width:980px;margin:0 auto;padding:24px 16px 48px}h1{font-size:22px;margin:0;display:flex;align-items:center}.logo{display:inline-block;width:22px;height:22px;border-radius:7px;margin-right:9px}h2{font-size:16px;margin:0}h3{font-size:12px;margin:0 0 6px;color:var(--muted);font-weight:600}
.top{display:flex;flex-wrap:wrap;gap:8px 16px;align-items:baseline;justify-content:space-between;margin-bottom:16px}.meta{color:var(--muted);font-size:12px;overflow-wrap:anywhere}
.totals{display:flex;flex-wrap:wrap;gap:8px;margin:0 0 16px;padding:0;list-style:none}.totals li{background:color-mix(in srgb,var(--c) 9%,var(--card));border:1px solid color-mix(in srgb,var(--c) 30%,var(--line));border-radius:8px;padding:6px 10px;min-width:84px}
.totals b{display:block;font-size:18px;font-variant-numeric:tabular-nums}.totals span{font-size:12px;color:var(--muted)}.sw{display:inline-block;width:9px;height:9px;border-radius:2px;margin-right:5px}
.tiles{display:flex;flex-wrap:wrap;gap:3px;margin:2px 0 8px}.tile{width:13px;height:13px;border-radius:3px;display:block}.tile.s-available,.sw.s-available{background:color-mix(in srgb,var(--accent) 40%,var(--card));box-shadow:inset 0 0 0 1.5px var(--available)}.tile.s-locked{background:repeating-linear-gradient(135deg,var(--hatch) 0 1.5px,transparent 1.5px 3.5px),color-mix(in srgb,var(--accent) 5%,var(--card))}.tile.lesson{border-radius:50%}.tile:hover,.tile:focus{outline:2px solid var(--fg);outline-offset:1px}
.track{padding:8px 0 6px;border-top:1px solid var(--line)}.track:first-of-type{border-top:0;padding-top:0}.track header{margin-bottom:6px;flex-wrap:wrap}.track .progress{margin:0;flex:1 1 auto}
details.all summary{cursor:pointer;color:var(--muted);font-size:12px;margin-top:4px}details.all[open] summary{margin-bottom:6px}
.notice{background:var(--card);border:1px solid var(--line);border-left:3px solid var(--stale);border-radius:8px;padding:8px 12px;margin:0 0 16px}
.card{background:var(--card);border:1px solid var(--line);border-radius:10px;padding:14px 16px;margin:0 0 16px;overflow-x:auto}
.card header{display:flex;justify-content:space-between;align-items:baseline;gap:8px;margin-bottom:10px}.slug,.tool{color:var(--muted);font-weight:400;font-size:12px}
.progress{margin:6px 0 10px;color:var(--muted);font-size:12px}.progress strong{color:var(--ink)}.pane code{background:color-mix(in srgb,var(--accent) 8%,var(--code))}
table{width:100%;border-collapse:collapse}th{text-align:left;font-size:11px;text-transform:uppercase;letter-spacing:.04em;color:var(--muted);font-weight:600;padding:6px 8px;border-bottom:1px solid var(--line)}
td{padding:6px 8px;border-bottom:1px solid var(--line);vertical-align:top}.num{text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
tr.ex[data-open]{cursor:pointer}tr.ex[data-open]:hover td{background:var(--tint)}td.name a{color:inherit;text-decoration:none}td.name a:hover{text-decoration:underline}
.tile.selected{outline:2px solid var(--fg);outline-offset:1px}.next{background:var(--tint);border:1px solid var(--soft);border-left:3px solid var(--accent);border-radius:8px;padding:8px 12px}.hints{margin:8px 0}.concept a{color:var(--ink)}.concept a.close{color:var(--muted)}
.badge{display:inline-block;font-size:11px;font-weight:600;padding:1px 7px;border-radius:999px;color:#fff;white-space:nowrap}
${STATUSES.map((s) => `.s-${s}{background:var(--${s})}`).join('')}.stale-mark{background:transparent;color:var(--stale);border:1px solid var(--stale)}.sw.s-locked{background:repeating-linear-gradient(135deg,var(--hatch) 0 1.5px,transparent 1.5px 3px)}.badge.s-locked{background:color-mix(in srgb,var(--accent) 6%,transparent);color:color-mix(in srgb,var(--ink) 70%,var(--muted));border:1px solid var(--soft)}.lock{margin-right:4px;vertical-align:-1px}tr.locked .name{color:var(--muted)}.after{font-size:12px;color:var(--muted)}
.date{white-space:nowrap;font-size:12px}.date .label{color:var(--muted)}.date.done time{color:var(--done);font-weight:600}.date.last-changed time{font-style:italic}.date.uncommitted{color:var(--stale);font-style:italic}.none{color:var(--muted)}
.details{padding:4px 0 6px 14px}.details ul{list-style:none;margin:0;padding:0}.details li{padding:2px 0}.mark{display:inline-block;width:14px;font-weight:700}
.t-pass .mark{color:var(--done)}.t-fail .mark,.t-error .mark{color:var(--failing)}pre{margin:2px 0 4px 14px;padding:6px 8px;background:var(--code);border-radius:6px;white-space:pre-wrap;word-break:break-word;font:12px/1.4 ui-monospace,SFMono-Regular,Menlo,monospace}
.ran{color:var(--muted);font-size:11px;margin:4px 0 0}code{font:12px ui-monospace,Menlo,monospace;background:var(--code);padding:1px 4px;border-radius:4px;overflow-wrap:anywhere}
@media (max-width:600px){.totals li{min-width:0;flex:1 1 72px}th.num.diff,td.num.diff{display:none}td,th{padding:6px 4px}}
.months{display:flex;flex-wrap:wrap;gap:16px}.grid{display:grid;grid-template-columns:repeat(7,26px);gap:3px}.wd{font-size:10px;color:var(--muted);text-align:center}
.day{height:26px;border-radius:4px;background:var(--code);font-size:9px;color:var(--muted);position:relative;padding:1px 3px;line-height:1}.day.pad{background:none}.day b{font-weight:400}
.day.hit{background:color-mix(in srgb,var(--done) 22%,var(--card));color:var(--fg)}.dot{display:inline-block;width:5px;height:5px;border-radius:50%;background:var(--done);margin:1px}
.empty{color:var(--muted)}
.tabs{display:flex;gap:4px;margin:0 0 16px;border-bottom:1px solid var(--line)}.tabs a,.picker a{color:var(--muted);text-decoration:none;padding:6px 12px;border-radius:8px 8px 0 0;font-weight:600}
.tabs a:hover,.picker a:hover{color:var(--ink)}.tabs a[aria-current]{color:var(--fg);background:var(--card);border:1px solid var(--line);border-bottom-color:var(--card);margin-bottom:-1px;box-shadow:inset 0 3px 0 var(--accent)}section.tab.card{border-top:3px solid var(--accent)}
.picker{display:flex;flex-wrap:wrap;gap:4px;margin:0 0 12px}.picker a{border-radius:999px;padding:3px 12px;font-size:13px;border:1px solid var(--line)}.picker a i{display:inline-block;width:8px;height:8px;border-radius:50%;background:var(--accent);margin-right:6px}.picker a:hover{border-color:var(--accent)}.picker a[aria-current]{color:#fff;background:var(--accent);border-color:var(--accent)}.picker a[aria-current] i{background:#fff}
.overview td{vertical-align:middle}.overview .name a{color:inherit;text-decoration:none}.count{display:inline-flex;gap:8px;align-items:center;color:var(--muted);text-decoration:none;font-size:12px}.count strong{color:var(--ink)}
.tmark{display:inline-grid;place-items:center;width:24px;height:24px;border-radius:7px;margin-right:8px;vertical-align:middle;background:linear-gradient(135deg,var(--accent),color-mix(in srgb,var(--accent) 70%,#000));color:#fff;font-size:10px;font-weight:700}
.bar{display:inline-block;width:90px;height:6px;border-radius:3px;background:color-mix(in srgb,var(--accent) 16%,var(--code));overflow:hidden}.bar i{display:block;height:100%;background:var(--accent)}
.tiles.big .tile,.pane .tiles .tile{width:18px;height:18px;border-radius:5px}
.map{position:relative;padding:4px 0 8px}.edges{position:absolute;inset:0;width:100%;height:100%;pointer-events:none;overflow:visible}.edges path{fill:none;stroke:var(--soft);stroke-width:1.5}.edges path.near{stroke:var(--accent);stroke-width:2}
.level{position:relative;display:flex;flex-wrap:wrap;justify-content:center;gap:10px 12px;margin:0 0 26px}
.node{display:inline-flex;align-items:center;gap:6px;padding:5px 11px;border-radius:999px;font-size:12px;font-weight:600;text-decoration:none;color:#fff;border:1.5px solid transparent;background-clip:padding-box}
.node i{display:inline-block;width:7px;height:7px;border-radius:50%;background:currentColor;opacity:.7}.node.s-available{background:color-mix(in srgb,var(--accent) 22%,var(--card));color:var(--fg);border-color:var(--available)}
.node.s-locked{background:color-mix(in srgb,var(--accent) 6%,var(--card));color:color-mix(in srgb,var(--ink) 70%,var(--muted));border:1.5px dashed var(--soft)}.group{display:inline-flex;gap:4px;padding:3px;border-radius:999px;border:1px solid transparent}.group:has(.node+.node){border-color:var(--soft);background:color-mix(in srgb,var(--accent) 4%,transparent)}.group.near,.group:hover{border-color:var(--accent)}.node:hover,.node:focus{outline:2px solid var(--accent);outline-offset:1px}.node.selected{outline:2px solid var(--fg);outline-offset:2px}
.concept{border:1px solid var(--line);border-top:3px solid var(--accent);border-radius:10px;padding:12px 16px;margin:0 0 16px;background:var(--bg)}.concept header{display:flex;justify-content:space-between;align-items:baseline}.close{color:var(--muted);text-decoration:none;font-size:20px;line-height:1}
.blurb{color:var(--muted);margin:4px 0 8px}.lesson{display:flex;flex-wrap:wrap;gap:6px;align-items:center}.practised,.links{padding-left:18px}.practised li{margin:2px 0}
.md h3{font-size:14px;color:var(--ink);margin:16px 0 6px}.md h4{font-size:13px;margin:12px 0 4px}.md pre.code{margin:6px 0 10px}.md aside.admonition{margin:8px 0 12px;padding:8px 12px;border-left:3px solid var(--accent);background:var(--code);border-radius:6px}.md aside.admonition>p.admonition-title{margin:0 0 4px;font-weight:600;color:var(--accent)}.md aside.admonition>:last-child{margin-bottom:0}.md aside.caution,.md aside.warning{border-left-color:var(--stale)}.md aside.caution>p.admonition-title,.md aside.warning>p.admonition-title{color:var(--stale)}.md table.md{width:auto;margin:6px 0 12px}.md table.md td,.md table.md th{text-transform:none;letter-spacing:0;font-size:12px}`;

const JS = `
document.querySelectorAll('tr.ex').forEach(function(row){
  row.addEventListener('click',function(e){if(e.target.closest('a'))return;location.hash=row.dataset.open;});
});
// Tabs and tracks live in the hash, #<tab>/<track>[/<concept> | /lesson/<slug> | /<exercise>], so a reload or a link keeps the view.
function show(pane,id){
  var open=null;pane.querySelectorAll('article.concept').forEach(function(a){a.hidden=a.id!==id;if(!a.hidden)open=a;});
  if(open)open.scrollIntoView({block:'nearest'});
}
var clean=function(s){return s.replace(/[^A-Za-z0-9_-]/g,'-');};
var lastTrack={};
function edges(pane){
  var map=pane.querySelector('.map');if(!map)return;var svg=map.querySelector('.edges');var box=map.getBoundingClientRect();var out='';
  map.querySelectorAll('.group').forEach(function(g){
    (g.dataset.builds||'').split(' ').filter(Boolean).forEach(function(slug){
      var p=map.querySelector('.group[data-lesson="'+slug+'"]');if(!p)return;var a=p.getBoundingClientRect(),b=g.getBoundingClientRect();
      var x1=a.left+a.width/2-box.left,y1=a.bottom-box.top,x2=b.left+b.width/2-box.left,y2=b.top-box.top,m=(y1+y2)/2;
      out+='<path data-from="'+slug+'" data-to="'+g.dataset.lesson+'" d="M'+x1+' '+y1+'C'+x1+' '+m+' '+x2+' '+m+' '+x2+' '+y2+'"/>';
    });
  });
  svg.innerHTML=out;
}
// Highlights a lesson's links and the lessons at their other ends.
function near(pane,lesson){
  pane.querySelectorAll('.near').forEach(function(x){x.classList.remove('near');});if(!lesson)return;
  pane.querySelectorAll('.edges path').forEach(function(p){
    if(p.dataset.from===lesson||p.dataset.to===lesson){p.classList.add('near');var o=pane.querySelector('.group[data-lesson="'+(p.dataset.from===lesson?p.dataset.to:p.dataset.from)+'"]');if(o)o.classList.add('near');}
  });
}
function lessonOf(pane,concept){var n=concept&&pane.querySelector('.node[data-concept="'+concept+'"]');return n?n.parentNode.dataset.lesson:'';}
function route(){
  var parts=location.hash.slice(1).split('/');var tab=['learn','practice'].indexOf(parts[0])>=0?parts[0]:'overview';
  document.querySelectorAll('.tabs a').forEach(function(a){if(a.dataset.tab===tab)a.setAttribute('aria-current','page');else a.removeAttribute('aria-current');});
  document.querySelectorAll('section.tab').forEach(function(s){s.hidden=s.dataset.tab!==tab;});
  if(tab==='overview'){document.body.style.removeProperty('--accent');return;}
  var section=document.querySelector('section.tab[data-tab="'+tab+'"]');var panes=section.querySelectorAll('.pane');if(!panes.length)return;
  var track=parts[1]||lastTrack[tab]||lastTrack.any||panes[0].dataset.track;var pane=section.querySelector('.pane[data-track="'+track+'"]')||panes[0];track=pane.dataset.track;
  lastTrack[tab]=lastTrack.any=track;
  panes.forEach(function(p){p.hidden=p!==pane;});
  document.body.style.setProperty('--accent',pane.style.getPropertyValue('--accent'));
  section.querySelectorAll('.picker a').forEach(function(a){if(a.dataset.track===track)a.setAttribute('aria-current','page');else a.removeAttribute('aria-current');});
  if(tab==='learn'){
    edges(pane);var lesson=parts[2]==='lesson'?parts[3]||'':'';var sel=lesson?'':parts[2]||'';
    pane.querySelectorAll('.node').forEach(function(n){n.classList.toggle('selected',n.dataset.concept===sel||(!!lesson&&n.parentNode.dataset.lesson===lesson));});
    show(pane,lesson?'ep-'+clean(track+'-'+lesson):'cp-'+clean(track+'-'+sel));
    near(pane,lesson||lessonOf(pane,sel));
  } else {
    var slug=parts[2]||'';
    pane.querySelectorAll('.tile').forEach(function(x){x.classList.toggle('selected',x.dataset.slug===slug);});
    show(pane,'ep-'+clean(track+'-'+slug));
  }
}
document.querySelectorAll('.map .group').forEach(function(g){
  var pane=g.closest('.pane');
  g.addEventListener('mouseenter',function(){near(pane,g.dataset.lesson);});
  g.addEventListener('mouseleave',function(){near(pane,lessonOf(pane,location.hash.split('/')[2]||''));});
});
window.addEventListener('hashchange',route);
window.addEventListener('resize',function(){var p=document.querySelector('section.tab[data-tab="learn"]:not([hidden]) .pane:not([hidden])');if(p)edges(p);});
route();`;

export function renderHtml(data: DashboardData): string {
  // The data, for anything reading the page, less the docs' texts, which the page already holds.
  const json = JSON.stringify(data, (k, v) => (k === 'instructions' || k === 'hints' || k === 'about' ? undefined : v)).replace(/</g, '\\u003c');
  const totals = STATUSES.map((s) => `<li style="--c:var(--${s})"><b style="color:var(--${s})">${data.totals[s]}</b><span><i class="sw s-${s}"></i>${s}</span></li>`).join('');
  const meta = [
    data.git.branch ? `${esc(data.git.branch)} @ ${esc(data.git.sha ?? '?')}` : 'not a git repository',
    data.lastRunAt ? `last run ${esc(data.lastRunAt)}` : 'no runs on this machine',
    data.doctor ? `doctor ${data.doctor.ok ? 'ok' : 'reports problems'} (${esc(data.doctor.checkedAt.slice(0, 10))})` : 'doctor never run',
  ].join(' · ');
  // The logo: a wheel of the tracks' colours.
  const colors = data.tracks.filter((t) => t.listed).map((t) => t.color);
  const logo = colors.length ? [...colors, colors[0]].join(',') : 'var(--brand),var(--brand)';
  const notice = data.neverRun
    ? `<p class="notice"><strong>${data.neverRun}</strong> workspace${data.neverRun === 1 ? ' has' : 's have'} never run on this machine — <code>npx quest test --run-missing</code></p>`
    : '';
  return `<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Sidequest</title><style>${CSS}</style></head>
<body><main>
<div class="top"><h1><span class="logo" style="background:conic-gradient(${esc(logo)})"></span>Sidequest</h1><span class="meta">${meta}</span></div>
<nav class="tabs"><a href="#overview" data-tab="overview">Overview</a><a href="#learn" data-tab="learn">Learn</a><a href="#practice" data-tab="practice">Practice</a></nav>
<section class="tab" data-tab="overview">
<ul class="totals">${totals}</ul>
${notice}
${tracksOverview(data)}
${inProgress(data)}
${calendar(data)}
</section>
<section class="tab card" data-tab="learn" hidden>${picker(data, 'learn')}${data.tracks.filter((t) => t.listed).map(learnPane).join('\n')}</section>
<section class="tab card" data-tab="practice" hidden>${picker(data, 'practice')}${data.tracks.filter((t) => t.listed).map(practicePane).join('\n')}</section>
<p class="meta">Rendered ${esc(data.generatedAt)}</p>
</main>
<script type="application/json" id="dashboard-data">${json}</script>
<script>${JS}</script>
</body></html>
`;
}
