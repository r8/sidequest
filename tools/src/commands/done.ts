import { existsSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { parseArgs } from 'node:util';
import { compareDiff } from '../core/compare.ts';
import { QuestError } from '../core/errors.ts';
import { bold, green } from '../core/format.ts';
import { DONE_FILE, solutionHash, today, writeDone } from '../core/done.ts';
import { commitDone, isRepo } from '../core/git.ts';
import { repoRoot } from '../core/paths.ts';
import { confirm } from '../core/prompt.ts';
import { parseExerciseRef } from '../core/refs.ts';
import { readResult } from '../core/results.ts';
import { cacheStatusOf } from '../core/status.ts';
import { clearToolVersions, toolVersion } from '../core/toolversion.ts';
import { exerciseFiles, findTrack, loadExercise, type Exercise } from '../core/track.ts';
import { workspaceDir } from '../core/workspace.ts';
import { currentRunKey } from '../runner/run.ts';

export default async function done(args: string[]): Promise<number> {
  const { values, positionals } = parseArgs({ args, allowPositionals: true, options: { yes: { type: 'boolean', short: 'y' } } });
  const ref = parseExerciseRef(positionals[0], 'done');
  const name = `${ref.track}/${ref.slug}`;
  const root = repoRoot();
  if (!isRepo(root)) throw new QuestError(`${root} is not a git repository`);
  const load = () => loadExercise(findTrack(root, ref.track), ref.slug, root);
  const exercise = load();
  const workspace = workspaceDir(root, ref.track, ref.slug);
  if (!existsSync(workspace)) throw new QuestError(`no workspace for ${name}; run \`quest start ${name}\``);

  // Checked again after the prompt, from a fresh read of everything the run key covers: the solution,
  // the track and exercise config, or the installed toolchain may change while it is open.
  const refuseUnlessPassing = (exercise: Exercise) => {
    const result = readResult(root, ref.track, ref.slug);
    const tool = toolVersion(root, exercise.track);
    // First: without a usable toolchain there is no current result, and the toolchain is the fix.
    if (tool.problem) throw new QuestError(`refusing to mark ${name} done: ${tool.problem}`);
    const status = cacheStatusOf(result, currentRunKey(root, exercise));
    if (status !== 'passing') {
      const why = {
        null: 'it has no test result on this machine',
        stale: 'its test result is stale (the solution, tests, harness, configuration, runner or toolchain changed since it ran)',
        failing: 'its tests do not pass',
      }[String(status) as 'null' | 'stale' | 'failing'];
      throw new QuestError(`refusing to mark ${name} done: ${why}; run \`quest test ${name}\``);
    }
  };
  refuseUnlessPassing(exercise);

  process.stdout.write(`${bold(`Your solution vs. the example for ${name}:`)}\n\n${compareDiff(root, exercise)}\n`);
  if (!(await confirm(`Commit ${name} as done?`, values.yes, 'commit'))) {
    process.stdout.write('aborted\n');
    return 1;
  }
  clearToolVersions();
  const fresh = load();
  refuseUnlessPassing(fresh);
  // A done record counts as done whether or not it was committed, so a failed commit puts back the
  // record that was there before, or none.
  const marker = join(workspace, DONE_FILE);
  const previous = existsSync(marker) ? readFileSync(marker) : null;
  writeDone(workspace, today(), solutionHash(workspace, exerciseFiles(fresh).solution));
  let sha: string;
  try {
    sha = commitDone(root, workspace, name);
  } catch (err) {
    if (previous) writeFileSync(marker, previous);
    else rmSync(marker, { force: true });
    throw err;
  }
  process.stdout.write(`${green('✓')} ${name} is done (${sha}). Push it with \`git push\`.\n`);
  return 0;
}
