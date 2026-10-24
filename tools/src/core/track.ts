// Track loader: Exercism's config.json + this project's quest.json, and per-exercise .meta/config.json.
import { existsSync, readdirSync, statSync } from 'node:fs';
import { join } from 'node:path';
import { ExerciseConfig } from '../schema/exercise-config.ts';
import { QuestJson } from '../schema/quest-json.ts';
import { TrackConfig } from '../schema/track-config.ts';
import { QuestError } from './errors.ts';
import { parseJsonFile } from './json.ts';
import { display, repoRoot, tracksDir } from './paths.ts';
import { expandTemplate } from './template.ts';

export interface Track {
  slug: string;
  dir: string;
  config: TrackConfig;
  quest: QuestJson;
}

export type ExerciseKind = 'concept' | 'practice';

/** A track's config.json entry for a lesson (concept exercise) or a practice exercise, in one shape. */
export interface ExerciseEntry {
  kind: ExerciseKind;
  slug: string;
  name: string;
  uuid: string;
  difficulty: number | null; // lessons have none
  concepts: string[]; // what a lesson teaches
}

export interface Exercise {
  track: Track;
  slug: string;
  kind: ExerciseKind;
  entry: ExerciseEntry;
  dir: string;
  meta: ExerciseConfig;
}

export function loadTrack(dir: string, root = repoRoot()): Track {
  const slug = dir.split('/').filter(Boolean).at(-1)!;
  const config = parseJsonFile(join(dir, 'config.json'), TrackConfig, display(root, join(dir, 'config.json')));
  const quest = parseJsonFile(join(dir, 'quest.json'), QuestJson, display(root, join(dir, 'quest.json')));
  return { slug, dir, config, quest };
}

/** Directories under tracks/ that hold a config.json, sorted by name. */
export function trackDirs(root = repoRoot()): string[] {
  const base = tracksDir(root);
  if (!existsSync(base)) return [];
  return readdirSync(base)
    .filter((name) => !name.startsWith('.'))
    .map((name) => join(base, name))
    .filter((dir) => statSync(dir).isDirectory() && existsSync(join(dir, 'config.json')))
    .sort();
}

export function loadTracks(root = repoRoot()): Track[] {
  return trackDirs(root).map((dir) => loadTrack(dir, root));
}

export function findTrack(root: string, slug: string): Track {
  const dir = join(tracksDir(root), slug);
  if (!existsSync(join(dir, 'config.json'))) {
    const known = trackDirs(root).map((d) => d.split('/').at(-1)).join(', ') || 'none';
    throw new QuestError(`unknown track "${slug}" (tracks: ${known})`);
  }
  return loadTrack(dir, root);
}

export const exerciseDir = (track: Track, slug: string, kind: ExerciseKind = 'practice') => join(track.dir, 'exercises', kind, slug);

/** Every listed exercise: the lessons in syllabus order, then the practice exercises in config.json order. */
export function listedEntries(track: Track): ExerciseEntry[] {
  const { concept, practice } = track.config.exercises;
  return [
    ...concept.map((e) => ({ kind: 'concept' as const, slug: e.slug, name: e.name, uuid: e.uuid, difficulty: null, concepts: e.concepts })),
    ...practice.map((e) => ({ kind: 'practice' as const, slug: e.slug, name: e.name, uuid: e.uuid, difficulty: e.difficulty, concepts: [] })),
  ];
}

export function listedSlugs(track: Track): string[] {
  return listedEntries(track).map((e) => e.slug);
}

export function loadExercise(track: Track, slug: string, root = repoRoot()): Exercise {
  const entry = listedEntries(track).find((e) => e.slug === slug);
  if (!entry) throw new QuestError(`"${slug}" is not listed in ${display(root, join(track.dir, 'config.json'))}`);
  const dir = exerciseDir(track, slug, entry.kind);
  const metaPath = join(dir, '.meta', 'config.json');
  const meta = parseJsonFile(metaPath, ExerciseConfig, display(root, metaPath));
  return { track, slug, kind: entry.kind, entry, dir, meta };
}

/** Exercise file lists from its .meta/config.json; `example` is the reference solution, a lesson's exemplar. */
export function exerciseFiles(exercise: Exercise): { solution: string[]; test: string[]; example: string[] } {
  const { files } = exercise.meta;
  return {
    solution: files.solution,
    test: files.test,
    example: (exercise.kind === 'concept' ? files.exemplar : files.example) ?? [],
  };
}

/** The track's file templates for a new exercise; a lesson's reference solution is its exemplar. */
export function trackTemplates(track: Track, slug: string, kind: ExerciseKind = 'practice'): { solution: string[]; test: string[]; example: string[] } {
  const t = track.config.files;
  const example = kind === 'concept' ? (t.exemplar ?? t.example.map((x) => x.replace(/example(?=\.[^/]*$)/, 'exemplar'))) : t.example;
  return {
    solution: t.solution.map((x) => expandTemplate(x, slug)),
    test: t.test.map((x) => expandTemplate(x, slug)),
    example: example.map((x) => expandTemplate(x, slug)),
  };
}

export function timeoutFor(exercise: Exercise): number {
  return exercise.meta.custom?.timeoutMs ?? exercise.track.quest.test.timeoutMs;
}
