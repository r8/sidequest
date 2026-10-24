// Exercism's track config.json — only the fields the tooling reads are checked here;
// `configlet lint` owns the rest of the format.
import { z } from 'zod';

export const PracticeExerciseEntry = z.looseObject({
  slug: z.string().min(1),
  name: z.string().min(1),
  uuid: z.string().min(1),
  practices: z.array(z.string()).default([]),
  prerequisites: z.array(z.string()).default([]),
  difficulty: z.number().int(),
  status: z.string().optional(),
});
export type PracticeExerciseEntry = z.infer<typeof PracticeExerciseEntry>;

// A lesson: Exercism's concept exercise. `concepts` are the ones it teaches; `prerequisites` are derived
// from its custom.after (the concepts those lessons teach), because configlet lint wants them.
export const ConceptExerciseEntry = z.looseObject({
  slug: z.string().min(1),
  name: z.string().min(1),
  uuid: z.string().min(1),
  concepts: z.array(z.string()).min(1),
  prerequisites: z.array(z.string()).default([]),
  status: z.string().optional(),
});
export type ConceptExerciseEntry = z.infer<typeof ConceptExerciseEntry>;

export const Concept = z.looseObject({ uuid: z.string().min(1), slug: z.string().min(1), name: z.string().min(1) });

export const FileTemplates = z.looseObject({
  solution: z.array(z.string().min(1)).min(1),
  test: z.array(z.string().min(1)).min(1),
  example: z.array(z.string().min(1)).min(1),
  exemplar: z.array(z.string().min(1)).min(1).optional(),
});

export const TrackConfig = z.looseObject({
  language: z.string().min(1),
  slug: z.string().min(1),
  active: z.boolean(),
  blurb: z.string(),
  version: z.literal(3),
  files: FileTemplates,
  exercises: z.looseObject({
    concept: z.array(ConceptExerciseEntry).default([]),
    practice: z.array(PracticeExerciseEntry).default([]),
  }),
  concepts: z.array(Concept).default([]),
});
export type TrackConfig = z.infer<typeof TrackConfig>;
