import { relative, resolve, join } from 'node:path';
import { fileURLToPath } from 'node:url';

/** The repository root. QUEST_ROOT overrides it so tests can point the tooling at a fixture repo. */
export function repoRoot(): string {
  const override = process.env.QUEST_ROOT;
  return override ? resolve(override) : fileURLToPath(new URL('../../../', import.meta.url)).replace(/\/$/, '');
}

export const tracksDir = (root: string) => join(root, 'tracks');
export const solutionsDir = (root: string) => join(root, 'solutions');
export const cacheDir = (root: string) => join(root, '.cache');
export const resultsDir = (root: string) => join(cacheDir(root), 'results');
export const stagingDir = (root: string) => join(cacheDir(root), 'staging');
export const buildDir = (root: string, track: string) => join(cacheDir(root), 'build', track);
export const doctorFile = (root: string) => join(cacheDir(root), 'doctor.json');

/** A path for messages: relative to the root when inside it, absolute otherwise. */
export function display(root: string, path: string): string {
  const rel = relative(root, path);
  return rel && !rel.startsWith('..') ? rel : path;
}
