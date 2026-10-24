// Exercism's test-runner results.json, version 2, and the cached form that adds five fields.
import { z } from 'zod';

export const RunStatus = z.enum(['pass', 'fail', 'error']);
export type RunStatus = z.infer<typeof RunStatus>;

export const TestResult = z.looseObject({
  name: z.string(),
  status: RunStatus,
  test_code: z.string().nullable().optional(),
  message: z.string().nullable().optional(),
  output: z.string().nullable().optional(),
  task_id: z.number().int().optional(),
});
export type TestResult = z.infer<typeof TestResult>;

export const Results = z.looseObject({
  version: z.literal(2),
  status: RunStatus,
  message: z.string().nullable().optional(),
  tests: z.array(TestResult).default([]),
});
export type Results = z.infer<typeof Results>;

export const CACHE_VERSION = 1;

export const CachedResult = z.looseObject({
  ...Results.shape,
  v: z.literal(CACHE_VERSION),
  runKey: z.string().startsWith('sha256:'),
  ranAt: z.iso.datetime(),
  durationMs: z.number().nonnegative(),
  toolVersion: z.string(),
});
export type CachedResult = z.infer<typeof CachedResult>;
