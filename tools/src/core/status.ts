// Status derivation: each workspace's done record, git history (last-changed dates) and the local
// results cache (the rest).
import { existsSync } from 'node:fs';
import { join, relative } from 'node:path';
import { currentRunKey } from '../runner/run.ts';
import type { Status } from '../schema/dashboard.ts';
import type { CachedResult } from '../schema/results.ts';
import { QuestError } from './errors.ts';
import { doneRecords, solutionHash, type DoneRecord } from './done.ts';
import { lastChanged } from './git.ts';
import { readResult } from './results.ts';
import { exerciseFiles, listedEntries, loadExercise, type Exercise, type ExerciseEntry, type Track } from './track.ts';
import { listWorkspaces, workspaceDir } from './workspace.ts';

export type CacheStatus = 'passing' | 'failing' | 'stale';

export interface ExerciseState {
  track: string;
  slug: string;
  entry: ExerciseEntry | null; // null for an orphan
  exercise: Exercise | null;
  workspace: string | null;
  result: CachedResult | null; // ignored (null) for an orphan
  cacheStatus: CacheStatus | null;
  done: DoneRecord | null;
  // Done, but the solution has changed since: still done, with a note.
  editedSinceDone: boolean;
  // The exercises of its `after` that are not done; with no workspace, they keep it locked.
  waitingOn: string[];
  status: Status;
  date: { kind: 'done' | 'last-changed' | 'uncommitted'; value: string | null } | null;
}

export interface GitView {
  done: Map<string, DoneRecord>;
  changed: Map<string, string>;
}

export function gitView(root: string): GitView {
  return { done: doneRecords(root), changed: lastChanged(root) };
}

export function cacheStatusOf(result: CachedResult | null, key: string | null): CacheStatus | null {
  if (!result) return null;
  if (key === null || result.runKey !== key) return 'stale';
  return result.status === 'pass' ? 'passing' : 'failing';
}

/** The exercises of `exercise`'s `after` that have no done record, in the order listed. */
export function waitingOn(exercise: Exercise, done: Map<string, DoneRecord>): string[] {
  return (exercise.meta.custom?.after ?? []).filter((slug) => !done.has(`${exercise.track.slug}/${slug}`));
}

function headline(done: DoneRecord | null, workspace: string | null, cache: CacheStatus | null, waiting: string[]): Status {
  if (done) return 'done';
  if (!workspace) return waiting.length ? 'locked' : 'available';
  return cache ?? 'started';
}

function dateFor(root: string, git: GitView, workspace: string | null, files: string[], done: DoneRecord | null): ExerciseState['date'] {
  if (done) return { kind: 'done', value: done.date };
  if (!workspace) return null;
  const dates = files.map((f) => git.changed.get(relative(root, join(workspace, f)))).filter((d): d is string => !!d);
  if (!dates.length) return { kind: 'uncommitted', value: null };
  return { kind: 'last-changed', value: dates.sort().at(-1)! };
}

/** States for every listed exercise of `track` (the lessons, then the practice exercises), then its orphan workspaces. */
export function trackStates(root: string, track: Track, git: GitView): ExerciseState[] {
  const states: ExerciseState[] = [];
  const listed = new Set<string>();
  for (const entry of listedEntries(track)) {
    listed.add(entry.slug);
    const ref = `${track.slug}/${entry.slug}`;
    let exercise: Exercise | null = null;
    try {
      exercise = loadExercise(track, entry.slug, root);
    } catch (err) {
      if (!(err instanceof QuestError)) throw err;
    }
    const wsDir = workspaceDir(root, track.slug, entry.slug);
    const workspace = existsSync(wsDir) ? wsDir : null;
    const result = workspace ? readResult(root, track.slug, entry.slug) : null;
    const key = result && exercise ? currentRunKey(root, exercise) : null;
    const cacheStatus = cacheStatusOf(result, key);
    const done = git.done.get(ref) ?? null;
    const files = exercise ? exerciseFiles(exercise).solution : [];
    const waiting = exercise ? waitingOn(exercise, git.done) : [];
    states.push({
      track: track.slug,
      slug: entry.slug,
      entry,
      exercise,
      workspace,
      result,
      cacheStatus,
      done,
      editedSinceDone: !!(done && workspace && exercise) && solutionHash(workspace, files) !== done.solution,
      waitingOn: waiting,
      status: headline(done, workspace, cacheStatus, waiting),
      date: dateFor(root, git, workspace, files, done),
    });
  }
  for (const ws of listWorkspaces(root, track.slug)) {
    if (listed.has(ws.slug)) continue;
    states.push(orphan(root, git, ws.track, ws.slug, ws.dir));
  }
  return states;
}

function orphan(root: string, git: GitView, track: string, slug: string, dir: string): ExerciseState {
  const done = git.done.get(`${track}/${slug}`) ?? null;
  const prefix = relative(root, dir) + '/';
  const dates = [...git.changed].filter(([p]) => p.startsWith(prefix)).map(([, d]) => d).sort();
  return {
    track,
    slug,
    entry: null,
    exercise: null,
    workspace: dir,
    result: null,
    cacheStatus: null,
    done,
    editedSinceDone: false,
    waitingOn: [],
    status: 'orphan',
    date: done ? { kind: 'done', value: done.date } : dates.length ? { kind: 'last-changed', value: dates.at(-1)! } : { kind: 'uncommitted', value: null },
  };
}

/** Workspaces under solutions/<track>/ whose track directory no longer exists. */
export function orphanTracks(root: string, tracks: Track[], git: GitView): ExerciseState[] {
  const known = new Set(tracks.map((t) => t.slug));
  return listWorkspaces(root)
    .filter((ws) => !known.has(ws.track))
    .map((ws) => orphan(root, git, ws.track, ws.slug, ws.dir));
}
