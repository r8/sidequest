// The tooling never calls a tool by bare name: every spawn goes through `mise exec --`.
import { join } from 'node:path';
import { existsSync, readFileSync } from 'node:fs';
import { z } from 'zod';
import { capture, onPath } from './proc.ts';
import { parseToml } from './toml.ts';

export const miseAvailable = (() => {
  let cached: boolean | undefined;
  return () => (cached ??= onPath('mise'));
})();

const MiseLs = z.record(
  z.string(),
  z.array(
    z.looseObject({
      version: z.string(),
      requested_version: z.string().optional(),
      installed: z.boolean().optional(),
      active: z.boolean().optional(),
      source: z.looseObject({ path: z.string().optional() }).optional(),
    }),
  ),
);
export interface ResolvedTool {
  name: string;
  requested: string | null;
  version: string;
  installed: boolean;
  sourcePath: string | null;
}

const lsCache = new Map<string, ResolvedTool[]>();

/** Forgets what mise resolved, for a long-lived process (the dashboard server) that must see an upgrade. */
export function clearMiseCache(): void {
  lsCache.clear();
}

/** `mise ls --current --json`, run from `cwd`; one entry per tool that resolves there. */
export function miseCurrent(cwd: string): ResolvedTool[] {
  const hit = lsCache.get(cwd);
  if (hit) return hit;
  if (!miseAvailable()) return [];
  const r = capture('mise', ['ls', '--current', '--json'], { cwd });
  if (r.code !== 0) return [];
  const parsed = MiseLs.safeParse(JSON.parse(r.stdout || '{}'));
  if (!parsed.success) return [];
  const tools = Object.entries(parsed.data).flatMap(([name, entries]) =>
    entries.map((e) => ({
      name,
      requested: e.requested_version ?? null,
      version: e.version,
      installed: e.installed ?? false,
      sourcePath: e.source?.path ?? null,
    })),
  );
  lsCache.set(cwd, tools);
  return tools;
}

/** Tool keys pinned in <root>/mise.toml's [tools] table, with their raw pins. */
export function misePins(root: string): Map<string, string> {
  const file = join(root, 'mise.toml');
  if (!existsSync(file)) return new Map();
  const tools = parseToml(readFileSync(file, 'utf8')).get('tools') ?? new Map();
  return new Map([...tools].map(([k, v]) => [k, String(v)]));
}

/** The mise tool key that provides a runner: the key itself, or a backend key ending in /<runner> or :<runner>. */
export function pinFor(pins: Map<string, string>, runner: string): string | null {
  for (const key of pins.keys()) {
    if (key === runner || key.endsWith(`/${runner}`) || key.endsWith(`:${runner}`)) return key;
  }
  return null;
}

/** The version mise resolves for the runner's tool from `root`, or null when unresolved. */
export function resolvedVersion(root: string, runner: string): string | null {
  const key = pinFor(misePins(root), runner);
  if (!key) return null;
  const tool = miseCurrent(root).find((t) => t.name === key);
  return tool?.installed ? tool.version : null;
}

export function miseExecArgv(argv: string[]): [string, string[]] {
  return ['mise', ['exec', '--', ...argv]];
}

/** Whether `configlet` runs through mise; returns its version or null. */
export function configletVersion(root: string): string | null {
  if (!miseAvailable()) return null;
  const r = capture('mise', ['exec', '--', 'configlet', '--version'], { cwd: root });
  return r.code === 0 ? r.stdout.trim() || r.stderr.trim() : null;
}
