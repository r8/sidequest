import { copyFileSync, existsSync, mkdirSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { parseArgs } from 'node:util';
import { HELP, HINTS, README, exerciseHints, exerciseReadme, trackHelp } from '../core/docs.ts';
import { doneRecords } from '../core/done.ts';
import { QuestError } from '../core/errors.ts';
import { display, repoRoot } from '../core/paths.ts';
import { confirm } from '../core/prompt.ts';
import { parseExerciseRef } from '../core/refs.ts';
import { waitingOn } from '../core/status.ts';
import { exerciseFiles, findTrack, loadExercise, type Exercise } from '../core/track.ts';
import { workspaceDir } from '../core/workspace.ts';

function copyInto(exercise: Exercise, workspace: string, files: string[]): void {
  for (const file of files) {
    const source = join(exercise.dir, file);
    if (!existsSync(source)) throw new QuestError(`${file} is missing from the track's ${exercise.slug} exercise`);
    const target = join(workspace, file);
    mkdirSync(dirname(target), { recursive: true });
    copyFileSync(source, target);
  }
}

// README.md, HELP.md and a lesson's HINTS.md are generated from the track's .docs/ every time, so they never go stale.
function writeDocs(exercise: Exercise, workspace: string): void {
  mkdirSync(workspace, { recursive: true });
  writeFileSync(join(workspace, README), exerciseReadme(exercise));
  writeFileSync(join(workspace, HELP), trackHelp(exercise.track, exercise.slug));
  const hints = exerciseHints(exercise);
  if (hints) writeFileSync(join(workspace, HINTS), hints);
}

export default async function start(args: string[]): Promise<number> {
  const { values, positionals } = parseArgs({
    args,
    allowPositionals: true,
    options: { force: { type: 'boolean' }, unlock: { type: 'boolean' }, yes: { type: 'boolean', short: 'y' }, 'refresh-tests': { type: 'boolean' } },
  });
  const ref = parseExerciseRef(positionals[0], 'start');
  const root = repoRoot();
  const exercise = loadExercise(findTrack(root, ref.track), ref.slug, root);
  const files = exerciseFiles(exercise);
  const workspace = workspaceDir(root, ref.track, ref.slug);
  const label = display(root, workspace);

  if (values['refresh-tests']) {
    if (!existsSync(workspace)) throw new QuestError(`no workspace at ${label}; run \`quest start ${ref.track}/${ref.slug}\` first`);
    copyInto(exercise, workspace, files.test);
    writeDocs(exercise, workspace);
    process.stdout.write(`re-copied the tests and ${README}/${HELP} into ${label}: ${files.test.join(', ')}\n`);
    return 0;
  }
  // Only a new workspace waits for its `after`: one already there was started, unlocked or not.
  const waiting = existsSync(workspace) ? [] : waitingOn(exercise, doneRecords(root));
  if (waiting.length && !values.unlock) {
    const refs = waiting.map((slug) => `${ref.track}/${slug}`).join(', ');
    throw new QuestError(`${ref.track}/${ref.slug} is locked until ${refs} ${waiting.length > 1 ? 'are' : 'is'} done; \`quest start --unlock ${ref.track}/${ref.slug}\` starts it anyway`);
  }
  if (existsSync(workspace)) {
    if (!values.force) throw new QuestError(`${label} already exists; --force overwrites the stub and tests, --refresh-tests re-copies the tests only`);
    const ok = await confirm(`Overwrite ${files.solution.join(', ')} and the tests in ${label}? Your solution will be lost.`, values.yes, 'overwrite a workspace');
    if (!ok) {
      process.stdout.write('aborted\n');
      return 1;
    }
  }
  copyInto(exercise, workspace, [...files.solution, ...files.test]);
  writeDocs(exercise, workspace);
  process.stdout.write(`${values.force ? 'reset' : 'started'} ${ref.track}/${ref.slug} in ${label}\n`);
  process.stdout.write(`  read:  ${display(root, join(workspace, README))}\n`);
  process.stdout.write(`  edit:  ${files.solution.map((f) => display(root, join(workspace, f))).join(', ')}\n`);
  process.stdout.write(`  test:  npx quest test ${ref.track}/${ref.slug}\n`);
  process.stdout.write(`  done:  npx quest done ${ref.track}/${ref.slug}\n`);
  return 0;
}
