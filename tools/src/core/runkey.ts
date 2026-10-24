// runKey: sha256 over the staged inputs, the quest.json test block, the resolved tool version and
// the runner adapter with the shared modules it runs with. A cached result whose runKey differs from
// the current one is stale.
import { createHash } from 'node:crypto';
import { existsSync, readFileSync } from 'node:fs';
import type { TestBlock } from '../schema/quest-json.ts';

export interface RunInput {
  /** Path inside the staging directory. */
  path: string;
  /** Absolute source path. */
  source: string;
  kind: 'solution' | 'test' | 'harness';
}

/** A module other than the adapter that a run's outcome depends on; path relative to tools/src. */
export interface SharedModule {
  path: string;
  source: Buffer;
}

/**
 * The adapter that ran (or would run) the tests: its name, its source (null when it is missing), and
 * the shared modules it runs with.
 */
export interface Adapter {
  name: string;
  source: Buffer | null;
  shared: SharedModule[];
}

export function computeRunKey(inputs: RunInput[], test: TestBlock, toolVersion: string, adapter: Adapter): string {
  const hash = createHash('sha256');
  for (const input of [...inputs].sort((a, b) => (a.path < b.path ? -1 : a.path > b.path ? 1 : 0))) {
    hash.update(input.path);
    hash.update('\0');
    if (existsSync(input.source)) hash.update(readFileSync(input.source));
    else hash.update('\0missing\0');
    hash.update('\0');
  }
  hash.update(JSON.stringify(test));
  hash.update('\0');
  hash.update(toolVersion);
  // How a run executes and how its output becomes results is the adapter's; a change there must not
  // leave results it would now read differently counting as current.
  hash.update('\0');
  hash.update(adapter.name);
  hash.update('\0');
  hash.update(adapter.source ?? '\0missing\0');
  // So is what the adapter's helpers and ctx.exec make of a run.
  for (const module of [...adapter.shared].sort((a, b) => (a.path < b.path ? -1 : a.path > b.path ? 1 : 0))) {
    hash.update('\0');
    hash.update(module.path);
    hash.update('\0');
    hash.update(module.source);
  }
  return `sha256:${hash.digest('hex')}`;
}
