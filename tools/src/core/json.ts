import { existsSync, readFileSync, renameSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname } from 'node:path';
import type { z } from 'zod';
import { QuestError } from './errors.ts';

/** "<file>: <field.path>: <message>" lines, one per issue. */
export function formatIssues(file: string, error: z.ZodError): string {
  return error.issues
    .map((issue) => `${file}: ${issue.path.length ? issue.path.join('.') : '(root)'}: ${issue.message}`)
    .join('\n');
}

export function parseJsonFile<S extends z.ZodType>(path: string, schema: S, label = path): z.infer<S> {
  if (!existsSync(path)) throw new QuestError(`${label}: file not found`);
  let raw: unknown;
  try {
    raw = JSON.parse(readFileSync(path, 'utf8'));
  } catch (err) {
    throw new QuestError(`${label}: invalid JSON: ${(err as Error).message}`);
  }
  const parsed = schema.safeParse(raw);
  if (!parsed.success) throw new QuestError(formatIssues(label, parsed.error));
  return parsed.data;
}

/** Writes via a temp file and rename, so a reader never sees half a file. */
export function writeJsonAtomic(path: string, value: unknown): void {
  mkdirSync(dirname(path), { recursive: true });
  const tmp = `${path}.${process.pid}.tmp`;
  writeFileSync(tmp, JSON.stringify(value, null, 2) + '\n');
  renameSync(tmp, path);
}
