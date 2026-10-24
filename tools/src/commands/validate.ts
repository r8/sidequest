import { existsSync, statSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { parseArgs } from 'node:util';
import { QuestError } from '../core/errors.ts';
import { miseAvailable } from '../core/mise.ts';
import { display, repoRoot } from '../core/paths.ts';
import { capture } from '../core/proc.ts';
import { trackDirs } from '../core/track.ts';
import { fixPrerequisites, validateTrack } from '../core/validate.ts';

export default async function validate(args: string[]): Promise<number> {
  const { values, positionals } = parseArgs({ args, allowPositionals: true, options: { strict: { type: 'boolean' }, fix: { type: 'boolean' } } });
  const root = repoRoot();
  const strict = values.strict || process.env.CI === 'true';
  let dirs: string[];
  if (positionals.length > 1) throw new QuestError('usage: quest validate [<dir>] [--fix]', 2);
  if (positionals[0]) {
    const dir = resolve(process.cwd(), positionals[0]);
    if (!existsSync(dir) || !statSync(dir).isDirectory()) throw new QuestError(`${positionals[0]}: not a directory`);
    dirs = [dir];
  } else {
    dirs = trackDirs(root);
    if (!dirs.length) {
      process.stdout.write('no tracks under tracks/; nothing to validate\n');
      return 0;
    }
  }

  const configlet = configletRunner(root);
  if (!configlet.ok) {
    const msg = `configlet unavailable (${configlet.reason}); skipping configlet lint and sync`;
    if (strict) {
      process.stderr.write(`error: ${msg} — fatal under CI=true or --strict\n`);
      return 1;
    }
    process.stderr.write(`warning: ${msg}\n`);
  }

  let failed = false;
  for (const dir of dirs) {
    const label = display(root, dir);
    if (values.fix && existsSync(join(dir, 'config.json'))) {
      const fixed = fixPrerequisites(dir, root);
      if (fixed) process.stdout.write(`${label}: wrote the prerequisites of ${fixed} lesson(s) from custom.after\n`);
    }
    const report = validateTrack(dir, root);
    if (configlet.ok) {
      const lint = capture('mise', ['exec', '--', 'configlet', 'lint', '-t', dir], { cwd: root });
      if (lint.code !== 0) report.errors.push(`configlet lint failed for ${label}:\n${indent(lint.stdout + lint.stderr)}`);
      if (report.track && report.track.config.exercises.practice.length) {
        const sync = capture('mise', ['exec', '--', 'configlet', 'sync', '-t', dir], { cwd: root });
        const output = sync.stdout + sync.stderr;
        const outcome = syncOutcome(sync.code, output);
        if (outcome === 'drift') report.warnings.push(`configlet sync reports unsynced exercises in ${label} (apply with \`configlet sync --update -t ${label}\`):\n${indent(output)}`);
        if (outcome === 'failed') {
          const msg = `configlet sync could not check ${label}:\n${indent(output)}`;
          // Upstream drift is advisory; a check that never ran is not a clean result.
          if (strict) report.errors.push(`${msg}\n    (fatal under CI=true or --strict)`);
          else report.warnings.push(msg);
        }
      }
    }
    for (const w of report.warnings) process.stderr.write(`warning: ${w}\n`);
    for (const e of report.errors) process.stderr.write(`error: ${e}\n`);
    if (report.errors.length) {
      failed = true;
      process.stderr.write(`✗ ${label}: ${report.errors.length} error(s)\n`);
    } else {
      process.stdout.write(`✓ ${label}\n`);
    }
  }
  return failed ? 1 : 0;
}

/**
 * What a `configlet sync` check found. It exits 1 both for unsynced exercises and when it could not
 * check at all (no network, an unwritable cache); only a check that got to the exercises reports them,
 * as `[warn]` lines after "Checking exercises...".
 */
export function syncOutcome(code: number | null, output: string): 'synced' | 'drift' | 'failed' {
  if (code === 0) return 'synced';
  const checked = output.split(/^Checking exercises\.\.\.$/m)[1];
  return checked !== undefined && /^\[warn\]/m.test(checked) ? 'drift' : 'failed';
}

function indent(text: string): string {
  return text.trimEnd().split('\n').map((l) => `    ${l}`).join('\n');
}

function configletRunner(root: string): { ok: true } | { ok: false; reason: string } {
  if (!miseAvailable()) return { ok: false, reason: 'mise is not on PATH' };
  const r = capture('mise', ['exec', '--', 'configlet', '--version'], { cwd: root });
  if (r.code !== 0) return { ok: false, reason: (r.stderr || r.stdout).trim().split('\n')[0] ?? 'not installed' };
  return { ok: true };
}
