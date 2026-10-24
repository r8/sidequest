// A workspace is the learner's copy of one exercise: solutions/<track>/<slug>/.
import { existsSync, readdirSync, statSync } from 'node:fs';
import { join } from 'node:path';
import { solutionsDir } from './paths.ts';

export interface WorkspaceRef {
  track: string;
  slug: string;
  dir: string;
}

export const workspaceDir = (root: string, track: string, slug: string) => join(solutionsDir(root), track, slug);

function subdirs(dir: string): string[] {
  if (!existsSync(dir)) return [];
  return readdirSync(dir)
    .filter((name) => !name.startsWith('.') && statSync(join(dir, name)).isDirectory())
    .sort();
}

export function listWorkspaces(root: string, track?: string): WorkspaceRef[] {
  const tracks = track ? [track] : subdirs(solutionsDir(root));
  return tracks.flatMap((t) => subdirs(join(solutionsDir(root), t)).map((slug) => ({ track: t, slug, dir: workspaceDir(root, t, slug) })));
}
