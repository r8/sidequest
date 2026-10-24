// The toolVersion that feeds a run key: what mise resolves for the track's tool, or, for a
// quest.json.toolchain track, what its versionCommand reports on this host right now.
import { existsSync, readFileSync } from 'node:fs';
import { DoctorReport } from '../schema/doctor.ts';
import type { Toolchain } from '../schema/quest-json.ts';
import { clearMiseCache, resolvedVersion } from './mise.ts';
import { doctorFile } from './paths.ts';
import { capture } from './proc.ts';
import type { Track } from './track.ts';

export function readDoctor(root: string): DoctorReport | null {
  const file = doctorFile(root);
  if (!existsSync(file)) return null;
  try {
    const parsed = DoctorReport.safeParse(JSON.parse(readFileSync(file, 'utf8')));
    return parsed.success ? parsed.data : null;
  } catch {
    return null;
  }
}

export interface ToolVersion {
  version: string | null;
  /** Why the version is unusable, when it is. */
  problem: string | null;
}

/**
 * Runs a toolchain's versionCommand where and how its tests run — on the host, or inside ci.image under
 * CI, with the track's test.env (a PATH there picks the binary) — and extracts the version with
 * versionPattern.
 */
export function observeToolchain(tc: Toolchain, env: Record<string, string> = {}, ci = process.env.CI === 'true'): string | null {
  const envArgs = Object.entries(env).flatMap(([k, v]) => ['-e', `${k}=${v}`]);
  const argv = tc.ci.image && ci ? ['docker', 'run', '--rm', ...envArgs, tc.ci.image, ...tc.versionCommand] : tc.versionCommand;
  const r = capture(argv[0]!, argv.slice(1), { env: { ...process.env, ...env } });
  if (r.code === null) return null;
  // Many tools print their version on stderr; ^ and $ match per line.
  const m = new RegExp(tc.versionPattern, 'm').exec(`${r.stdout}\n${r.stderr}`);
  return m ? (m[1] ?? m[0]) : null;
}

/** Whether a toolchain can run here at all: its platforms, unless CI runs it in its image. */
export function supportedHere(tc: Toolchain): boolean {
  return !tc.platforms || tc.platforms.includes(process.platform as 'linux') || (!!tc.ci.image && process.env.CI === 'true');
}

const observed = new Map<string, string | null>();

/** Forgets every resolved tool version, for a process that must see an upgrade (the dashboard server, done's last check). */
export function clearToolVersions(): void {
  observed.clear();
  clearMiseCache();
}

export function toolVersion(root: string, track: Track): ToolVersion {
  const tc = track.quest.toolchain;
  if (tc === null) {
    const v = resolvedVersion(root, track.quest.runner);
    return v ? { version: v, problem: null } : { version: null, problem: `mise does not resolve an installed "${track.quest.runner}"; run \`mise install\`` };
  }
  if (!supportedHere(tc)) return { version: null, problem: `${tc.bin} is not available on ${process.platform}; it runs on ${tc.platforms!.join(', ')}` };
  // Observed now, not taken from doctor's report: a tool upgraded, replaced or removed since doctor ran
  // must not keep old results current or key new ones with the old version. Once per process.
  const { env } = track.quest.test;
  const key = JSON.stringify([tc.versionCommand, tc.versionPattern, tc.ci.image ?? null, process.env.CI === 'true', env]);
  if (!observed.has(key)) observed.set(key, observeToolchain(tc, env));
  const version = observed.get(key)!;
  if (version === null) return { version: null, problem: `${tc.bin} not found on this host (\`${tc.versionCommand.join(' ')}\`); see tracks/${track.slug}/docs/INSTALLATION.md` };
  if (version !== tc.version) return { version, problem: `${tc.bin} ${version} does not match quest.json's ${tc.version}; see \`quest doctor\`` };
  return { version, problem: null };
}
