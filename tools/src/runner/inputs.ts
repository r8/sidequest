// What gets staged for a run: solution files (or examples, or the stubs, at the solution paths), canonical tests,
// harness — each at its path inside the staging directory. The same list feeds the run key.
import { join } from 'node:path';
import type { RunInput } from '../core/runkey.ts';
import { exerciseFiles, type Exercise } from '../core/track.ts';
import { workspaceDir } from '../core/workspace.ts';

export type Mode = 'workspace' | 'examples' | 'stubs';

export function runInputs(root: string, exercise: Exercise, mode: Mode): RunInput[] {
  const files = exerciseFiles(exercise);
  const ws = workspaceDir(root, exercise.track.slug, exercise.slug);
  const source = (path: string, i: number) => {
    if (mode === 'examples') return join(exercise.dir, files.example[i] ?? files.example[0]!);
    // The stub sits at the solution path in the exercise directory, where `quest start` copies it from.
    return mode === 'stubs' ? join(exercise.dir, path) : join(ws, path);
  };
  const solution: RunInput[] = files.solution.map((path, i) => ({ path, source: source(path, i), kind: 'solution' }));
  const tests: RunInput[] = files.test.map((path) => ({ path, source: join(exercise.dir, path), kind: 'test' }));
  const harness: RunInput[] = exercise.track.quest.harness.map((path) => ({ path, source: join(exercise.track.dir, path), kind: 'harness' }));
  return [...solution, ...tests, ...harness];
}
