// The three things the tooling asks git: --changed, last-changed dates, and the done commit.
import { existsSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { relative, resolve } from 'node:path';
import { QuestError } from './errors.ts';
import { capture } from './proc.ts';

function git(root: string, args: string[]): { ok: boolean; out: string; err: string } {
  const r = capture('git', args, { cwd: root });
  return { ok: r.code === 0, out: r.stdout, err: r.stderr.trim() };
}

export function isRepo(root: string): boolean {
  return git(root, ['rev-parse', '--is-inside-work-tree']).ok;
}

/** Last author date (YYYY-MM-DD) of every path git has seen under solutions/, keyed by repo-relative path. */
export function lastChanged(root: string): Map<string, string> {
  const r = git(root, ['log', '--format=%x01%as', '--name-only', '--', 'solutions/']);
  const map = new Map<string, string>();
  if (!r.ok) return map;
  for (const block of r.out.split('\x01').slice(1)) {
    const [date, ...files] = block.split('\n');
    for (const file of files.map((f) => f.trim()).filter(Boolean)) if (!map.has(file)) map.set(file, date!.trim());
  }
  return map;
}

/** The default base for --changed: the merge-base with origin/HEAD, or null when there is no such ref. */
export function defaultBase(root: string): string | null {
  const head = git(root, ['rev-parse', '--verify', '--quiet', 'origin/HEAD']);
  if (!head.ok) return null;
  const mb = git(root, ['merge-base', 'HEAD', 'origin/HEAD']);
  return mb.ok ? mb.out.trim() : null;
}

/** Paths under solutions/ changed since `base` (committed or not), plus untracked ones. */
export function changedPaths(root: string, base: string): string[] {
  const diff = git(root, ['diff', '--name-only', base, '--', 'solutions/']);
  if (!diff.ok) throw new QuestError(`git diff against ${base} failed: ${diff.err}`);
  const untracked = git(root, ['ls-files', '--others', '--exclude-standard', 'solutions/']);
  return [...new Set([...diff.out.split('\n'), ...untracked.out.split('\n')].map((l) => l.trim()).filter(Boolean))];
}

/**
 * The done commit: stage the whole workspace, its done record included, then commit only it,
 * leaving anything else already staged untouched. When either step fails (a hook, signing, a held
 * index lock), the index is put back as it was, so nothing is left staged that was not before.
 */
export function commitDone(root: string, workspace: string, exercise: string): string {
  const rel = relative(root, workspace);
  const [track, slug] = exercise.split('/');
  const index = resolve(root, git(root, ['rev-parse', '--git-path', 'index']).out.trim());
  const saved = existsSync(index) ? readFileSync(index) : null;
  const fail = (message: string): never => {
    if (saved) writeFileSync(index, saved);
    else rmSync(index, { force: true });
    throw new QuestError(message);
  };
  const add = git(root, ['add', '--', rel]);
  if (!add.ok) fail(`git add failed: ${add.err}`);
  const commit = git(root, ['commit', '--only', '--allow-empty', '-m', `solve(${track}): ${slug}`, '--', rel]);
  if (!commit.ok) fail(`git commit failed: ${commit.err || commit.out}`);
  return git(root, ['rev-parse', '--short', 'HEAD']).out.trim();
}

export function branchAndSha(root: string): { branch: string | null; sha: string | null } {
  const branch = git(root, ['rev-parse', '--abbrev-ref', 'HEAD']);
  const sha = git(root, ['rev-parse', '--short', 'HEAD']);
  return { branch: branch.ok ? branch.out.trim() : null, sha: sha.ok ? sha.out.trim() : null };
}
