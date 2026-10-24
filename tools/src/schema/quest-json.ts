// tracks/<track>/quest.json — this project's one addition to an Exercism track.
import { z } from 'zod';

const Argv = z.array(z.string().min(1)).min(1);

export const Toolchain = z.strictObject({
  bin: z.string().min(1),
  version: z.string().min(1),
  versionCommand: Argv,
  // Matched (multiline) against versionCommand's stdout and stderr; capture group 1, or the whole match, is the observed version.
  versionPattern: z.string().min(1).refine((p) => {
    try { new RegExp(p); return true; } catch { return false; }
  }, 'must be a valid regular expression'),
  // Host platforms the tool exists for (Node's process.platform names); doctor says so elsewhere.
  platforms: z.array(z.enum(['linux', 'darwin', 'freebsd', 'win32'])).min(1).optional(),
  ci: z.strictObject({
    install: z.array(Argv).default([]),
    image: z.string().min(1).optional(),
  }).default({ install: [] }),
});
export type Toolchain = z.infer<typeof Toolchain>;

export const TestBlock = z.strictObject({
  argv: Argv,
  env: z.record(z.string(), z.string()).default({}),
  timeoutMs: z.number().int().positive(),
});
export type TestBlock = z.infer<typeof TestBlock>;

export const QuestJson = z.strictObject({
  runner: z.string().regex(/^[a-z][a-z0-9-]*$/, 'must match ^[a-z][a-z0-9-]*$'),
  harness: z.array(z.string().min(1)).default([]),
  test: TestBlock,
  toolchain: Toolchain.nullable(),
  // The track's colour on the dashboard; without it, one is derived from the slug.
  color: z.string().regex(/^#[0-9a-fA-F]{6}$/, 'must be a #rrggbb colour').optional(),
});
export type QuestJson = z.infer<typeof QuestJson>;
