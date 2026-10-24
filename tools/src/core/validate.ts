// `quest validate`'s checks on one track directory: schemas, adapter, harness, exercise files,
// mise pins; configlet lint and sync are run by the command around this.
import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { runnerPath } from '../runner/load.ts';
import { QuestError } from './errors.ts';
import { misePins, pinFor } from './mise.ts';
import { display } from './paths.ts';
import { exerciseFiles, listedEntries, loadExercise, loadTrack, type Track } from './track.ts';

export interface Report {
  errors: string[];
  warnings: string[];
}

export function validateTrack(dir: string, root: string): Report & { track: Track | null } {
  const errors: string[] = [];
  const warnings: string[] = [];
  const rel = (p: string) => display(root, p);
  let track: Track;
  try {
    track = loadTrack(dir, root);
  } catch (err) {
    if (err instanceof QuestError) return { errors: err.message.split('\n'), warnings, track: null };
    throw err;
  }
  const { config, quest } = track;

  if (config.slug !== track.slug) errors.push(`${rel(join(dir, 'config.json'))}: slug: "${config.slug}" does not match directory name "${track.slug}"`);

  const adapter = runnerPath(quest.runner);
  if (!existsSync(adapter)) errors.push(`${rel(join(dir, 'quest.json'))}: runner: no adapter for "${quest.runner}"; expected ${display(root, adapter)}`);

  for (const file of quest.harness) {
    if (!existsSync(join(dir, file))) errors.push(`${rel(join(dir, 'quest.json'))}: harness: ${file} does not exist in the track`);
  }

  if (quest.toolchain === null && !pinFor(misePins(root), quest.runner)) {
    errors.push(`${rel(join(dir, 'quest.json'))}: runner "${quest.runner}" has no toolchain and no pin in mise.toml [tools]`);
  }

  const seen = new Set<string>();
  const after = new Map<string, { meta: string; slugs: string[] }>();
  for (const entry of listedEntries(track)) {
    if (seen.has(entry.slug)) errors.push(`${rel(join(dir, 'config.json'))}: exercise "${entry.slug}" is listed twice`);
    seen.add(entry.slug);
    let exercise;
    try {
      exercise = loadExercise(track, entry.slug, root);
    } catch (err) {
      if (err instanceof QuestError) {
        errors.push(...err.message.split('\n'));
        continue;
      }
      throw err;
    }
    const files = exerciseFiles(exercise);
    const meta = rel(join(exercise.dir, '.meta', 'config.json'));
    const reference = exercise.kind === 'concept' ? 'exemplar' : 'example';
    if (!files.example.length) errors.push(`${meta}: files.${reference}: missing; a ${exercise.kind === 'concept' ? 'lesson' : 'practice exercise'} names its reference solution there`);
    for (const kind of ['solution', 'test', 'example'] as const) {
      for (const file of files[kind]) {
        if (!existsSync(join(exercise.dir, file))) errors.push(`${meta}: files.${kind === 'example' ? reference : kind}: ${file} does not exist`);
      }
    }
    const overlap = files.solution.filter((f) => files.test.includes(f));
    if (overlap.length) errors.push(`${meta}: files: ${overlap.join(', ')} is both a solution and a test file`);
    if (files.example.length && files.example.length !== files.solution.length) {
      errors.push(`${meta}: files.${reference} has ${files.example.length} entries but files.solution has ${files.solution.length}; they correspond positionally`);
    }
    for (const file of quest.harness) {
      if (files.solution.includes(file) || files.test.includes(file)) errors.push(`${meta}: files: ${file} is also a harness file`);
    }
    const deps = exercise.meta.custom?.after;
    // Said every time, so a forgotten one cannot leave an exercise open from the start.
    if (!deps) errors.push(`${meta}: custom.after: missing; [] opens the exercise from the start, ["hello-world"] after hello-world`);
    after.set(entry.slug, { meta, slugs: deps ?? [] });
    if (exercise.kind === 'concept') errors.push(...unwritten(root, [join('.docs', 'introduction.md'), join('.docs', 'instructions.md'), join('.docs', 'hints.md'), join('.meta', 'config.json')].map((f) => join(exercise.dir, f))));
  }
  for (const concept of config.concepts) {
    const cdir = join(dir, 'concepts', concept.slug);
    errors.push(...unwritten(root, ['introduction.md', 'about.md', join('.meta', 'config.json')].map((f) => join(cdir, f))));
  }
  errors.push(...afterErrors(after, seen));
  for (const [slug, want] of lessonPrerequisites(track, after)) {
    const have = config.exercises.concept.find((e) => e.slug === slug)!.prerequisites;
    if (JSON.stringify(have) !== JSON.stringify(want)) {
      errors.push(`${rel(join(dir, 'config.json'))}: exercises.concept "${slug}": prerequisites ${JSON.stringify(have)} should be ${JSON.stringify(want)}, the concepts its custom.after teaches; \`quest validate --fix\` writes them`);
    }
  }
  return { errors, warnings, track };
}

/** The files of a lesson or concept that still hold `quest new --concept`'s TODO text. */
function unwritten(root: string, files: string[]): string[] {
  return files.filter((f) => existsSync(f) && /\bTODO\b/.test(readFileSync(f, 'utf8'))).map((f) => `${display(root, f)}: still holds the scaffold's TODO; write it (CLAUDE.md, "Writing lessons")`);
}

/**
 * Each lesson's prerequisites as configlet wants them, derived from custom.after, the one source of the
 * order: the concepts taught by the lessons it comes after, in that order.
 */
function lessonPrerequisites(track: Track, after: Map<string, { slugs: string[] }>): Map<string, string[]> {
  const teaches = new Map(track.config.exercises.concept.map((e) => [e.slug, e.concepts]));
  return new Map(track.config.exercises.concept.map((e) => [e.slug, [...new Set((after.get(e.slug)?.slugs ?? []).flatMap((s) => teaches.get(s) ?? []))]]));
}

/** Rewrites every lesson's prerequisites in config.json from custom.after; returns how many changed. */
export function fixPrerequisites(dir: string, root: string): number {
  const track = loadTrack(dir, root);
  const after = new Map<string, { slugs: string[] }>();
  for (const e of track.config.exercises.concept) {
    try {
      after.set(e.slug, { slugs: loadExercise(track, e.slug, root).meta.custom?.after ?? [] });
    } catch (err) {
      if (!(err instanceof QuestError)) throw err; // reported by validateTrack
    }
  }
  const want = lessonPrerequisites(track, after);
  const file = join(dir, 'config.json');
  const raw = JSON.parse(readFileSync(file, 'utf8')) as { exercises: { concept?: { slug: string; prerequisites?: string[] }[] } };
  let changed = 0;
  for (const e of raw.exercises.concept ?? []) {
    const w = want.get(e.slug);
    if (w && JSON.stringify(e.prerequisites ?? []) !== JSON.stringify(w)) {
      e.prerequisites = w;
      changed++;
    }
  }
  if (changed) writeFileSync(file, JSON.stringify(raw, null, 2) + '\n');
  return changed;
}

/**
 * What is wrong with the track's `custom.after` graph: unknown or repeated slugs, and cycles, which would
 * lock an exercise for good. Without a cycle every chain of `after` ends at an exercise open from the start.
 */
function afterErrors(after: Map<string, { meta: string; slugs: string[] }>, listed: Set<string>): string[] {
  const errors: string[] = [];
  for (const [slug, { meta, slugs }] of after) {
    for (const dep of new Set(slugs)) {
      if (dep === slug) errors.push(`${meta}: custom.after: an exercise cannot come after itself`);
      else if (!listed.has(dep)) errors.push(`${meta}: custom.after: "${dep}" is not an exercise of the track`);
      if (slugs.indexOf(dep) !== slugs.lastIndexOf(dep)) errors.push(`${meta}: custom.after: "${dep}" is listed twice`);
    }
  }
  // Depth-first, reporting each cycle once, from the first of its exercises in config.json order.
  const state = new Map<string, 'open' | 'closed'>();
  const visit = (slug: string, path: string[]) => {
    if (state.get(slug) === 'closed') return;
    if (state.get(slug) === 'open') {
      const cycle = [...path.slice(path.indexOf(slug)), slug];
      errors.push(`${after.get(slug)!.meta}: custom.after: a cycle locks these for good: ${cycle.join(' → ')}`);
      return;
    }
    state.set(slug, 'open');
    for (const dep of after.get(slug)?.slugs ?? []) if (after.has(dep) && dep !== slug) visit(dep, [...path, slug]);
    state.set(slug, 'closed');
  };
  for (const slug of after.keys()) visit(slug, []);
  return errors;
}
