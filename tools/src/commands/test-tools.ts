// node --test over tools/test/**/*.test.ts only — never bare, which would pick up fixtures.
import { passthrough } from '../core/proc.ts';
import { repoRoot } from '../core/paths.ts';

export default async function testTools(args: string[]): Promise<number> {
  const root = repoRoot();
  const env = { ...process.env };
  delete env.QUEST_ROOT;
  return passthrough(process.execPath, ['--test', ...args, 'tools/test/**/*.test.ts'], { cwd: root, env });
}
