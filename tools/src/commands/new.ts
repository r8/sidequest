// quest new <track>/<slug>: configlet create, canonical data over HTTPS, attribution, stub,
// empty example and tests (generated when the adapter can, a TODO skeleton otherwise).
import { existsSync, mkdirSync, writeFileSync } from 'node:fs';
import { randomUUID } from 'node:crypto';
import { dirname, join } from 'node:path';
import { parseArgs } from 'node:util';
import {
  ATTRIBUTION_FILE,
  appendConceptEntry,
  appendPracticeEntry,
  attribution,
  fetchCanonical,
  filterCanonical,
  readTestsToml,
  setAfter,
  titleCase,
  todoSkeleton,
} from '../core/authoring.ts';
import { QuestError, usage } from '../core/errors.ts';
import { display, repoRoot } from '../core/paths.ts';
import { capture } from '../core/proc.ts';
import { parseExerciseRef } from '../core/refs.ts';
import { expandTemplate } from '../core/template.ts';
import { exerciseDir, exerciseFiles, findTrack, listedSlugs, loadExercise, trackTemplates, type Track } from '../core/track.ts';
import { loadRunner } from '../runner/load.ts';

function defaultAuthor(root: string): string | null {
  const r = capture('git', ['config', 'github.user'], { cwd: root });
  return r.code === 0 && r.stdout.trim() ? r.stdout.trim() : null;
}

function writeFiles(dir: string, files: Record<string, string>): void {
  for (const [path, content] of Object.entries(files)) {
    mkdirSync(dirname(join(dir, path)), { recursive: true });
    writeFileSync(join(dir, path), content);
  }
}

function blank(track: Track, slug: string, author: string, difficulty: number): void {
  const dir = exerciseDir(track, slug);
  const files = trackTemplates(track, slug);
  const meta = { authors: [author], files: { solution: files.solution, test: files.test, example: files.example }, blurb: `TODO: a one-line summary of ${titleCase(slug)}.` };
  writeFiles(dir, {
    '.docs/instructions.md': `# Instructions\n\nTODO: describe the ${titleCase(slug)} exercise.\n`,
    '.meta/config.json': JSON.stringify(meta, null, 2) + '\n',
    ...Object.fromEntries([...files.solution, ...files.test, ...files.example].map((f) => [f, ''])),
  });
  appendPracticeEntry(track.dir, { slug, name: titleCase(slug), uuid: randomUUID(), difficulty });
}

/**
 * A lesson (concept exercise), written by hand: TODO docs, empty stub, tests and exemplar, and for each
 * concept it teaches that the track does not list yet, the concept's docs under concepts/<slug>/.
 */
function lesson(track: Track, slug: string, name: string, author: string, concepts: string[], after: string[]): string[] {
  const taught = new Map(track.config.exercises.concept.flatMap((e) => e.concepts.map((c) => [c, e.slug] as const)));
  for (const c of concepts) if (taught.has(c)) throw usage(`--concept: ${c} is already taught by ${track.slug}/${taught.get(c)}; each concept has one lesson`);
  const dir = exerciseDir(track, slug, 'concept');
  const files = trackTemplates(track, slug, 'concept');
  const meta = { authors: [author], files: { solution: files.solution, test: files.test, exemplar: files.example }, blurb: `TODO: a one-line summary of what ${name} teaches.`, custom: { after } };
  writeFiles(dir, {
    '.docs/introduction.md': `# Introduction\n\nTODO: teach ${concepts.join(', ')}: everything the tasks need, with short examples.\n`,
    '.docs/instructions.md': `# Instructions\n\nTODO: the story, then numbered tasks.\n\n## 1. TODO: the first task\n\nTODO\n`,
    '.docs/hints.md': `# Hints\n\n## General\n\n- TODO\n\n## 1. TODO: the first task\n\n- TODO\n`,
    '.meta/config.json': JSON.stringify(meta, null, 2) + '\n',
    ...Object.fromEntries([...files.solution, ...files.test, ...files.example].map((f) => [f, ''])),
  });
  const known = new Set(track.config.concepts.map((c) => c.slug));
  const fresh = concepts.filter((c) => !known.has(c)).map((c) => ({ slug: c, name: titleCase(c), uuid: randomUUID() }));
  for (const c of fresh) {
    writeFiles(join(track.dir, 'concepts', c.slug), {
      'about.md': `# About\n\nTODO: ${c.name} in ${track.config.language}, in depth: what the lesson's introduction leaves out.\n`,
      'introduction.md': `# Introduction\n\nTODO: ${c.name} in ${track.config.language}, briefly.\n`,
      'links.json': '[]\n',
      '.meta/config.json': JSON.stringify({ blurb: `TODO: ${c.name} in one line.`, authors: [author], contributors: [] }, null, 2) + '\n',
    });
  }
  appendConceptEntry(track.dir, { slug, name, uuid: randomUUID(), concepts, after }, fresh);
  return fresh.map((c) => c.slug);
}

export default async function newExercise(args: string[]): Promise<number> {
  const { values, positionals } = parseArgs({
    args,
    allowPositionals: true,
    options: { blank: { type: 'boolean' }, author: { type: 'string' }, difficulty: { type: 'string' }, after: { type: 'string' }, concept: { type: 'string' }, name: { type: 'string' } },
  });
  const ref = parseExerciseRef(positionals[0], 'new');
  const root = repoRoot();
  const track = findTrack(root, ref.track);
  const kind = values.concept === undefined ? 'practice' : 'concept';
  const dir = exerciseDir(track, ref.slug, kind);
  if (existsSync(dir) || listedSlugs(track).includes(ref.slug)) {
    throw new QuestError(`${ref.track}/${ref.slug} already exists (${display(root, dir)})`);
  }
  const author = values.author ?? defaultAuthor(root);
  if (!author) throw usage('no author: pass --author <github-username> or set `git config github.user`');
  const difficulty = Number(values.difficulty ?? 1);
  if (!Number.isInteger(difficulty) || difficulty < 1 || difficulty > 10) throw usage('--difficulty must be an integer from 1 to 10');
  // The exercises to do first: hello-world unless said otherwise (a lesson: the last lesson so far);
  // --after '' opens it from the start.
  const lastLesson = track.config.exercises.concept.at(-1)?.slug;
  const after = (values.after ?? (kind === 'concept' && lastLesson ? lastLesson : 'hello-world')).split(',').map((s) => s.trim()).filter(Boolean);
  const unknown = after.filter((slug) => !listedSlugs(track).includes(slug));
  if (unknown.length) throw usage(`--after: ${unknown.join(', ')} is not an exercise of ${ref.track}`);

  if (kind === 'concept') {
    const concepts = values.concept!.split(',').map((s) => s.trim()).filter(Boolean);
    if (!concepts.length) throw usage('--concept names the concepts the lesson teaches: --concept <slug>[,<slug>…]');
    const name = values.name ?? titleCase(ref.slug);
    const fresh = lesson(track, ref.slug, name, author, concepts, after);
    const created = loadExercise(findTrack(root, ref.track), ref.slug, root);
    const rel = (f: string) => display(root, join(dir, f));
    const files = exerciseFiles(created);
    process.stdout.write(`created the lesson ${ref.track}/${ref.slug} (${concepts.join(', ')}) in ${display(root, dir)}\n`);
    process.stdout.write(`left to do by hand (CLAUDE.md, "Writing lessons", describes how the lessons so far are written):\n`);
    process.stdout.write(`  - write .docs/introduction.md, instructions.md and hints.md, and the blurb in .meta/config.json\n`);
    for (const c of fresh) process.stdout.write(`  - write concepts/${c}/: about.md, introduction.md, links.json and the blurb\n`);
    process.stdout.write(`  - write the stub ${files.solution.map(rel).join(', ')}, the tests ${files.test.map(rel).join(', ')} and the exemplar ${files.example.map(rel).join(', ')}\n`);
    process.stdout.write(`  - then: npx quest validate && npx quest test ${ref.track}/${ref.slug} --examples && npx quest test ${ref.track}/${ref.slug} --stubs\n`);
    return 0;
  }

  if (values.blank) {
    blank(track, ref.slug, author, difficulty);
    setAfter(dir, after);
    process.stdout.write(`created the original exercise ${ref.track}/${ref.slug} in ${display(root, dir)}\n`);
    process.stdout.write(`left to do by hand:\n  - write .docs/instructions.md and the blurb in .meta/config.json\n  - write the stub, the tests and .meta/example.*\n  - run \`quest validate\` and \`quest test ${ref.track}/${ref.slug} --examples\`\n`);
    return 0;
  }

  const canonical = await fetchCanonical(ref.slug);
  const create = capture('mise', ['exec', '--', 'configlet', 'create', '-t', track.dir, '--practice-exercise', ref.slug, '--author', author, '--difficulty', String(difficulty)], { cwd: root });
  if (create.code !== 0) throw new QuestError(`configlet create failed:\n${create.stdout}${create.stderr}`);

  const reloaded = findTrack(root, ref.track);
  const exercise = loadExercise(reloaded, ref.slug, root);
  writeFileSync(join(dir, '.docs', ATTRIBUTION_FILE), attribution(ref.slug));
  setAfter(dir, after);

  const included = filterCanonical(canonical, readTestsToml(join(dir, '.meta', 'tests.toml')));
  const { runner } = await loadRunner(reloaded.quest.runner);
  const generated = runner.generateTests?.(included, exercise.meta) ?? null;
  const tests: Record<string, string> = {};
  for (const file of exercise.meta.files.test) {
    tests[file] = generated?.[file] ?? todoSkeleton(included, ref.slug, runner.lineComment ?? '#');
  }
  const examples = Object.fromEntries(exerciseFiles(exercise).example.map((f) => [f, '']));
  writeFiles(dir, { ...examples, ...tests });

  const rel = (f: string) => display(root, join(dir, expandTemplate(f, ref.slug)));
  process.stdout.write(`created ${ref.track}/${ref.slug} in ${display(root, dir)} from problem-specifications\n`);
  process.stdout.write(`left to do by hand:\n`);
  process.stdout.write(`  - write the stub: ${exercise.meta.files.solution.map(rel).join(', ')}\n`);
  process.stdout.write(`  - write the example: ${exerciseFiles(exercise).example.map(rel).join(', ')}\n`);
  process.stdout.write(generated ? `  - review the generated tests: ${exercise.meta.files.test.map(rel).join(', ')}\n` : `  - write the tests from the TODO skeleton: ${exercise.meta.files.test.map(rel).join(', ')}\n`);
  process.stdout.write(`  - set "difficulty" in ${display(root, join(reloaded.dir, 'config.json'))} (now ${difficulty})\n`);
  process.stdout.write(`  - then: npx quest test ${ref.track}/${ref.slug} --examples\n`);
  return 0;
}
