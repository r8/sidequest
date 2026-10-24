// `compare`: a unified diff of each workspace files.solution[i] against the track's files.example[i].
import { existsSync } from 'node:fs';
import { join } from 'node:path';
import { QuestError } from './errors.ts';
import { display } from './paths.ts';
import { capture } from './proc.ts';
import { exerciseFiles, type Exercise } from './track.ts';
import { workspaceDir } from './workspace.ts';

export function compareDiff(root: string, exercise: Exercise, color = process.stdout.isTTY && !process.env.NO_COLOR): string {
  const files = exerciseFiles(exercise);
  const ws = workspaceDir(root, exercise.track.slug, exercise.slug);
  let out = '';
  files.solution.forEach((solution, i) => {
    const example = join(exercise.dir, files.example[i] ?? files.example[0]!);
    const mine = join(ws, solution);
    if (!existsSync(mine)) throw new QuestError(`${display(root, mine)} does not exist`);
    if (!existsSync(example)) throw new QuestError(`${display(root, example)} does not exist`);
    const r = capture('git', ['diff', '--no-index', `--color=${color ? 'always' : 'never'}`, '--', display(root, example), display(root, mine)], { cwd: root });
    if (r.code === 0) out += `${display(root, mine)} is identical to the example\n`;
    else if (r.code === 1) out += r.stdout;
    else throw new QuestError(`git diff failed: ${r.stderr.trim()}`);
  });
  return out;
}
