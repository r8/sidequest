// DashboardData: everything renderHtml() needs, built per request by buildData().
import { z } from 'zod';
import { RunStatus } from './results.ts';

export const STATUSES = ['done', 'passing', 'failing', 'stale', 'started', 'available', 'locked', 'orphan'] as const;
export const Status = z.enum(STATUSES);
export type Status = z.infer<typeof Status>;

export const DateLabel = z.object({
  kind: z.enum(['done', 'last-changed', 'uncommitted']),
  value: z.string().nullable(),
});

export const DashboardExercise = z.object({
  slug: z.string(),
  // A lesson (Exercism's concept exercise) or a practice exercise; an orphan counts as practice.
  kind: z.enum(['concept', 'practice']),
  name: z.string(),
  difficulty: z.number().nullable(),
  status: Status,
  // The local cache's view, kept alongside `done` so "done but failing" is visible.
  cacheStatus: z.enum(['passing', 'failing', 'stale']).nullable(),
  // Done, but the solution has changed since it was marked done.
  editedSinceDone: z.boolean(),
  // Its custom.after, and those of them not done yet, which keep it locked.
  after: z.array(z.string()),
  waitingOn: z.array(z.string()),
  date: DateLabel.nullable(),
  passed: z.number().nullable(),
  total: z.number().nullable(),
  ranAt: z.string().nullable(),
  message: z.string().nullable(),
  tests: z.array(z.object({ name: z.string(), status: RunStatus, message: z.string().nullable() })),
  // For its page: the blurb, its .docs/ as Markdown (introduction, instructions, append; hints apart), the source.
  blurb: z.string().nullable(),
  instructions: z.string(),
  hints: z.string().nullable(),
  source: z.object({ text: z.string(), url: z.string().nullable() }).nullable(),
});
export type DashboardExercise = z.infer<typeof DashboardExercise>;

// One concept of a track's syllabus, for the Learn tab's map: its docs, the lesson teaching it, and its row
// (how many lessons deep that lesson is in the lessons' custom.after).
export const DashboardConcept = z.object({
  slug: z.string(),
  name: z.string(),
  blurb: z.string().nullable(),
  lesson: z.string().nullable(),
  level: z.number(),
  about: z.string(), // Markdown
  links: z.array(z.object({ url: z.string(), description: z.string() })),
});
export type DashboardConcept = z.infer<typeof DashboardConcept>;

export const DashboardTrack = z.object({
  slug: z.string(),
  language: z.string(),
  color: z.string(),
  toolVersion: z.string().nullable(),
  listed: z.number(),
  done: z.number(),
  passing: z.number(),
  exercises: z.array(DashboardExercise),
  concepts: z.array(DashboardConcept),
});
export type DashboardTrack = z.infer<typeof DashboardTrack>;

export const DashboardData = z.object({
  generatedAt: z.string(),
  git: z.object({ branch: z.string().nullable(), sha: z.string().nullable() }),
  totals: z.record(Status, z.number()),
  lastRunAt: z.string().nullable(),
  neverRun: z.number(),
  doctor: z.object({ checkedAt: z.string(), ok: z.boolean() }).nullable(),
  tracks: z.array(DashboardTrack),
  calendar: z.array(z.object({ date: z.string(), exercise: z.string() })),
});
export type DashboardData = z.infer<typeof DashboardData>;
