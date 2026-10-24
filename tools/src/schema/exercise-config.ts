// An exercise's .meta/config.json (Exercism format). A practice exercise's reference solution is
// files.example, a lesson's files.exemplar; validate checks the right one is there. `custom` is Exercism's escape hatch;
// this project reads `custom.timeoutMs` and `custom.after` (the exercises of the track to do first) from it.
import { z } from 'zod';

export const ExerciseConfig = z.looseObject({
  authors: z.array(z.string()).default([]),
  contributors: z.array(z.string()).optional(),
  files: z.looseObject({
    solution: z.array(z.string().min(1)).min(1),
    test: z.array(z.string().min(1)).min(1),
    example: z.array(z.string().min(1)).min(1).optional(),
    exemplar: z.array(z.string().min(1)).min(1).optional(),
  }),
  blurb: z.string(),
  source: z.string().optional(),
  source_url: z.string().optional(),
  custom: z.looseObject({ timeoutMs: z.number().int().positive().optional(), after: z.array(z.string().min(1)).optional() }).optional(),
});
export type ExerciseConfig = z.infer<typeof ExerciseConfig>;
