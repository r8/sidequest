// The results cache: .cache/results/<track>/<slug>.json, results.json v2 plus five fields.
import { existsSync, readFileSync, readdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { CachedResult } from '../schema/results.ts';
import { writeJsonAtomic } from './json.ts';
import { resultsDir } from './paths.ts';

export const resultPath = (root: string, track: string, slug: string) => join(resultsDir(root), track, `${slug}.json`);

/** The cached result, or null when absent, unreadable, or written by another cache schema version. */
export function readResult(root: string, track: string, slug: string): CachedResult | null {
  const path = resultPath(root, track, slug);
  if (!existsSync(path)) return null;
  try {
    const parsed = CachedResult.safeParse(JSON.parse(readFileSync(path, 'utf8')));
    return parsed.success ? parsed.data : null;
  } catch {
    return null;
  }
}

export function writeResult(root: string, track: string, slug: string, result: CachedResult): void {
  writeJsonAtomic(resultPath(root, track, slug), result);
}

/** Every cached result file as { track, slug, path }. */
export function listResults(root: string): { track: string; slug: string; path: string }[] {
  const base = resultsDir(root);
  if (!existsSync(base)) return [];
  return readdirSync(base).flatMap((track) => {
    const dir = join(base, track);
    try {
      return readdirSync(dir)
        .filter((f) => f.endsWith('.json'))
        .map((f) => ({ track, slug: f.slice(0, -'.json'.length), path: join(dir, f) }));
    } catch {
      return [];
    }
  });
}

export function deleteResult(path: string): void {
  rmSync(path, { force: true });
}
