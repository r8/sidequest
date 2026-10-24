import { join } from 'node:path';
import { passthrough } from '../core/proc.ts';
import { repoRoot } from '../core/paths.ts';

export default async function typecheck(): Promise<number> {
  const root = repoRoot();
  return passthrough(join(root, 'node_modules', '.bin', 'tsc'), ['--noEmit', '-p', root], { cwd: root });
}
