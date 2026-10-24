// A lock shared by every quest process on this machine: a directory holding one entry, named
// `<pid>-<uuid>` after its owner.
//
// It is taken by renaming a prepared directory, already holding the entry, onto the lock path. rename(2)
// replaces nothing or an empty directory and fails on a non-empty one, so there is never a moment
// when the lock exists without an owner, and a lock abandoned half-way (an empty directory) is simply
// replaced. An owner that is gone is removed by deleting its entry by name: of several processes that
// find the same dead owner only one deletes it, and none can delete a newer owner's entry.
import { randomUUID } from 'node:crypto';
import { mkdirSync, readdirSync, renameSync, rmSync, rmdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

function alive(pid: number): boolean {
  if (!Number.isInteger(pid) || pid <= 0) return false; // not an entry this lock writes
  try {
    process.kill(pid, 0);
    return true;
  } catch (err) {
    return (err as NodeJS.ErrnoException).code !== 'ESRCH';
  }
}

/** Runs `fn` holding the lock `path`, waiting for any other holder; `onWait` is called once if it has to wait. */
export async function withLock<T>(path: string, fn: () => Promise<T>, onWait?: () => void): Promise<T> {
  const entry = `${process.pid}-${randomUUID()}`;
  const prepared = `${path}.${entry}`;
  let waited = false;
  for (;;) {
    mkdirSync(prepared, { recursive: true });
    writeFileSync(join(prepared, entry), '');
    try {
      renameSync(prepared, path);
      break;
    } catch (err) {
      const code = (err as NodeJS.ErrnoException).code;
      if (code === 'ENOTDIR') rmSync(path, { force: true }); // a lock file from an older quest
      else if (code !== 'ENOTEMPTY' && code !== 'EEXIST') throw err;
    }
    let owner: string | undefined;
    try {
      owner = readdirSync(path)[0];
    } catch {
      continue; // released in the meantime
    }
    if (owner === undefined) continue; // emptied in the meantime: the next rename replaces it
    if (!alive(Number(owner.split('-')[0]))) {
      rmSync(join(path, owner), { force: true });
      continue;
    }
    if (!waited) onWait?.();
    waited = true;
    await new Promise((resolve) => setTimeout(resolve, 100));
  }
  try {
    return await fn();
  } finally {
    rmSync(join(path, entry), { force: true });
    try {
      rmdirSync(path);
    } catch {
      // Already taken by the next holder, which renamed its directory over the emptied one.
    }
  }
}
