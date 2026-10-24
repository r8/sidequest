// A throwaway repository with a copy of the real tracks/ and mise.toml, driven through the real CLI.
import { spawnSync } from 'node:child_process';
import { cpSync, mkdtempSync, realpathSync, rmSync, writeFileSync, mkdirSync, readFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

export const repo = fileURLToPath(new URL('../../', import.meta.url));
const cli = join(repo, 'tools/src/cli.ts');

export interface TempRepo {
  root: string;
  quest(args: string[], opts?: { input?: string }): { code: number | null; stdout: string; stderr: string };
  git(args: string[]): string;
  write(path: string, content: string): void;
  read(path: string): string;
  cleanup(): void;
}

export function tempRepo(opts: { tracks?: string[]; env?: NodeJS.ProcessEnv } = {}): TempRepo {
  const root = realpathSync(mkdtempSync(join(tmpdir(), 'quest-repo-')));
  for (const track of opts.tracks ?? ['janet']) cpSync(join(repo, 'tracks', track), join(root, 'tracks', track), { recursive: true });
  cpSync(join(repo, 'mise.toml'), join(root, 'mise.toml'));
  writeFileSync(join(root, '.gitignore'), '.cache/\ndashboard/\n');
  const env: NodeJS.ProcessEnv = {
    ...process.env,
    QUEST_ROOT: root,
    MISE_TRUSTED_CONFIG_PATHS: root,
    NO_COLOR: '1',
    GIT_AUTHOR_NAME: 'Test',
    GIT_AUTHOR_EMAIL: 'test@example.com',
    GIT_COMMITTER_NAME: 'Test',
    GIT_COMMITTER_EMAIL: 'test@example.com',
    ...opts.env,
  };
  delete env.CI;
  const git = (args: string[]) => {
    const r = spawnSync('git', args, { cwd: root, env, encoding: 'utf8' });
    if (r.status !== 0) throw new Error(`git ${args.join(' ')}: ${r.stderr}`);
    return r.stdout;
  };
  git(['init', '-q', '-b', 'main']);
  git(['add', '-A']);
  git(['commit', '-qm', 'init']);
  return {
    root,
    quest(args, o = {}) {
      const r = spawnSync(process.execPath, [cli, ...args], { cwd: root, env, encoding: 'utf8', input: o.input ?? '' });
      return { code: r.status, stdout: r.stdout, stderr: r.stderr };
    },
    git,
    write(path, content) {
      mkdirSync(dirname(join(root, path)), { recursive: true });
      writeFileSync(join(root, path), content);
    },
    read: (path) => readFileSync(join(root, path), 'utf8'),
    cleanup: () => rmSync(root, { recursive: true, force: true, maxRetries: 5 }),
  };
}

export const exampleOf = (track: string, slug: string, file = '.meta/example.janet') =>
  readFileSync(join(repo, 'tracks', track, 'exercises/practice', slug, file), 'utf8');
