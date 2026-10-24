// The done state: `quest done` writes solutions/<track>/<slug>/.done.json and commits it with the
// solution. A file rather than commit metadata, so squashing, rebasing or amending history cannot lose
// it, and two branches that each finish an exercise do not conflict.
import { createHash } from 'node:crypto';
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import { z } from 'zod';
import { QuestError } from './errors.ts';
import { writeJsonAtomic } from './json.ts';
import { listWorkspaces } from './workspace.ts';

export const DONE_FILE = '.done.json';

const DoneFile = z.object({
  done: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  solution: z.string().regex(/^[0-9a-f]{64}$/),
});

export interface DoneRecord {
  exercise: string; // <track>/<slug>
  date: string; // YYYY-MM-DD, the local date it was marked done
  solution: string; // solutionHash() of the solution files when it was marked done
}

/** The hash of the solution files (paths and contents, in order) that a done record keeps. */
export function solutionHash(workspace: string, files: string[]): string {
  const hash = createHash('sha256');
  for (const file of files) {
    const path = join(workspace, file);
    hash.update(`${file}\0`).update(existsSync(path) ? readFileSync(path) : Buffer.alloc(0)).update('\0');
  }
  return hash.digest('hex');
}

/** The workspace's done record, or null when it is not done. */
export function readDone(workspace: string, exercise: string): DoneRecord | null {
  const path = join(workspace, DONE_FILE);
  if (!existsSync(path)) return null;
  let parsed;
  try {
    parsed = DoneFile.safeParse(JSON.parse(readFileSync(path, 'utf8')));
  } catch {
    parsed = null;
  }
  if (!parsed?.success) throw new QuestError(`${path}: not a done record (expected {"done": "YYYY-MM-DD", "solution": "<sha256>"})`);
  return { exercise, date: parsed.data.done, solution: parsed.data.solution };
}

export function writeDone(workspace: string, date: string, solution: string): void {
  writeJsonAtomic(join(workspace, DONE_FILE), { done: date, solution });
}

/** Every workspace's done record, by <track>/<slug>. */
export function doneRecords(root: string): Map<string, DoneRecord> {
  const records = new Map<string, DoneRecord>();
  for (const ws of listWorkspaces(root)) {
    const ref = `${ws.track}/${ws.slug}`;
    const record = readDone(ws.dir, ref);
    if (record) records.set(ref, record);
  }
  return records;
}

/** Today's local date as YYYY-MM-DD. */
export function today(now = new Date()): string {
  const pad = (n: number) => String(n).padStart(2, '0');
  return `${now.getFullYear()}-${pad(now.getMonth() + 1)}-${pad(now.getDate())}`;
}
