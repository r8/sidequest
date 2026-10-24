import { existsSync } from 'node:fs';
import { parseArgs } from 'node:util';
import { compareDiff } from '../core/compare.ts';
import { QuestError } from '../core/errors.ts';
import { repoRoot } from '../core/paths.ts';
import { parseExerciseRef } from '../core/refs.ts';
import { findTrack, loadExercise } from '../core/track.ts';
import { workspaceDir } from '../core/workspace.ts';

export default async function compare(args: string[]): Promise<number> {
  const { positionals } = parseArgs({ args, allowPositionals: true, options: {} });
  const ref = parseExerciseRef(positionals[0], 'compare');
  const root = repoRoot();
  const exercise = loadExercise(findTrack(root, ref.track), ref.slug, root);
  if (!existsSync(workspaceDir(root, ref.track, ref.slug))) throw new QuestError(`no workspace for ${ref.track}/${ref.slug}; run \`quest start ${ref.track}/${ref.slug}\``);
  process.stdout.write(compareDiff(root, exercise));
  return 0;
}
