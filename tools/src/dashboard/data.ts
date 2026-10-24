// buildData(): reads every input the dashboard shows into one DashboardData, validated by zod.
// No side effects; called per request.
import { fallbackColor } from '../core/colors.ts';
import { branchAndSha } from '../core/git.ts';
import { repoRoot } from '../core/paths.ts';
import { gitView, orphanTracks, trackStates, type ExerciseState } from '../core/status.ts';
import { readDoctor, toolVersion } from '../core/toolversion.ts';
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import { loadTracks, type Track } from '../core/track.ts';
import { DashboardData, STATUSES, type DashboardConcept, type DashboardExercise, type Status } from '../schema/dashboard.ts';

const readText = (path: string) => (existsSync(path) ? readFileSync(path, 'utf8') : null);
function readJson(path: string): unknown {
  try {
    return JSON.parse(readText(path) ?? 'null');
  } catch {
    return null; // shown without it; validate reports the file
  }
}

/** The track's concepts in syllabus order, each placed by the depth of its lesson in the lessons' custom.after. */
function concepts(track: Track, states: ExerciseState[]): DashboardConcept[] {
  const lessons = new Map(states.filter((s) => s.entry?.kind === 'concept').map((s) => [s.slug, s]));
  const depth = new Map<string, number>();
  const level = (slug: string, seen = new Set<string>()): number => {
    if (depth.has(slug)) return depth.get(slug)!;
    seen.add(slug);
    const before = (lessons.get(slug)?.exercise?.meta.custom?.after ?? []).filter((s) => lessons.has(s) && !seen.has(s));
    const d = before.length ? 1 + Math.max(...before.map((s) => level(s, seen))) : 0;
    depth.set(slug, d);
    return d;
  };
  return [...lessons.values()].flatMap((lesson) =>
    lesson.entry!.concepts.map((slug) => {
      const dir = join(track.dir, 'concepts', slug);
      const meta = readJson(join(dir, '.meta', 'config.json')) as { blurb?: unknown } | null;
      const links = readJson(join(dir, 'links.json'));
      return {
        slug,
        name: track.config.concepts.find((c) => c.slug === slug)?.name ?? slug,
        blurb: typeof meta?.blurb === 'string' ? meta.blurb : null,
        lesson: lesson.slug,
        level: level(lesson.slug),
        about: readText(join(dir, 'about.md')) ?? readText(join(dir, 'introduction.md')) ?? '',
        links: Array.isArray(links) ? links.filter((l): l is { url: string; description: string } => typeof l?.url === 'string' && typeof l?.description === 'string').map(({ url, description }) => ({ url, description })) : [],
      };
    }),
  );
}

function exerciseRow(s: ExerciseState): DashboardExercise {
  const r = s.result;
  const meta = s.exercise?.meta;
  const doc = (name: string) => (s.exercise ? readText(join(s.exercise.dir, '.docs', name)) : null);
  return {
    slug: s.slug,
    kind: s.entry?.kind ?? 'practice',
    name: s.entry?.name ?? s.slug,
    difficulty: s.entry?.difficulty ?? null,
    status: s.status,
    cacheStatus: s.cacheStatus,
    editedSinceDone: s.editedSinceDone,
    after: s.exercise?.meta.custom?.after ?? [],
    waitingOn: s.waitingOn,
    date: s.date,
    passed: r ? r.tests.filter((t) => t.status === 'pass').length : null,
    total: r ? r.tests.length : null,
    ranAt: r?.ranAt ?? null,
    message: r?.message ?? null,
    tests: (r?.tests ?? []).map((t) => ({ name: t.name, status: t.status, message: t.message ?? null })),
    blurb: meta?.blurb ?? null,
    instructions: ['introduction.md', 'instructions.md', 'instructions.append.md'].map(doc).filter((d): d is string => !!d).join('\n\n'),
    hints: doc('hints.md'),
    source: meta?.source ? { text: meta.source, url: meta.source_url ?? null } : null,
  };
}

export function buildData(root = repoRoot(), now = new Date()): DashboardData {
  const git = gitView(root);
  const tracks = loadTracks(root);
  const totals = Object.fromEntries(STATUSES.map((s) => [s, 0])) as Record<Status, number>;
  let neverRun = 0;
  let lastRunAt: string | null = null;
  const count = (states: ExerciseState[]) => {
    for (const s of states) {
      totals[s.status]++;
      if (s.entry && s.workspace && !s.result) neverRun++;
      if (s.result && (!lastRunAt || s.result.ranAt > lastRunAt)) lastRunAt = s.result.ranAt;
    }
  };

  const trackRows = tracks.map((track) => {
    const states = trackStates(root, track, git);
    count(states);
    const listed = states.filter((s) => s.entry);
    return {
      slug: track.slug,
      language: track.config.language,
      color: track.quest.color ?? fallbackColor(track.slug),
      toolVersion: toolVersion(root, track).version,
      listed: listed.length,
      done: listed.filter((s) => s.status === 'done').length,
      passing: listed.filter((s) => s.status === 'passing').length,
      exercises: states.map(exerciseRow),
      concepts: concepts(track, states),
    };
  });
  const stray = orphanTracks(root, tracks, git);
  count(stray);
  if (stray.length) {
    trackRows.push({ slug: '(orphans)', language: 'Orphaned workspaces', color: '#8a8a92', toolVersion: null, listed: 0, done: 0, passing: 0, exercises: stray.map((s) => ({ ...exerciseRow(s), slug: `${s.track}/${s.slug}`, name: `${s.track}/${s.slug}` })), concepts: [] });
  }

  const doctor = readDoctor(root);
  return DashboardData.parse({
    generatedAt: now.toISOString(),
    git: branchAndSha(root),
    totals,
    lastRunAt,
    neverRun,
    doctor: doctor ? { checkedAt: doctor.checkedAt, ok: doctor.configlet.ok && doctor.tools.every((t) => t.ok) } : null,
    tracks: trackRows,
    calendar: [...git.done.values()].map((d) => ({ date: d.date, exercise: d.exercise })).sort((a, b) => a.date.localeCompare(b.date)),
  });
}
