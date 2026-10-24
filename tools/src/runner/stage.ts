// Staging: a fresh directory under .cache/staging/ with the run inputs copied in, so a test run
// never touches the workspace and always uses the track's canonical tests.
import { copyFileSync, existsSync, mkdirSync, mkdtempSync, rmSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { QuestError } from '../core/errors.ts';
import { display, stagingDir } from '../core/paths.ts';
import type { RunInput } from '../core/runkey.ts';

export interface Staged {
  dir: string;
  inputDir: string;
  outputDir: string;
  cleanup(): void;
}

export function stage(root: string, label: string, inputs: RunInput[]): Staged {
  for (const input of inputs) {
    // A missing solution file is the learner's problem and shows up as a load error; a missing test or
    // harness file is a broken track, which is a tooling failure.
    if (input.kind !== 'solution' && !existsSync(input.source)) {
      throw new QuestError(`${input.kind} file ${display(root, input.source)} is missing from the track`);
    }
  }
  mkdirSync(stagingDir(root), { recursive: true });
  const dir = mkdtempSync(join(stagingDir(root), `${label.replace(/\W+/g, '-')}-`));
  const inputDir = join(dir, 'input');
  const outputDir = join(dir, 'output');
  mkdirSync(inputDir);
  mkdirSync(outputDir);
  for (const input of inputs) {
    if (!existsSync(input.source)) continue;
    const target = join(inputDir, input.path);
    mkdirSync(dirname(target), { recursive: true });
    copyFileSync(input.source, target);
  }
  return { dir, inputDir, outputDir, cleanup: () => rmSync(dir, { recursive: true, force: true }) };
}
