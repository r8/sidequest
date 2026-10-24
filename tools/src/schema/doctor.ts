// .cache/doctor.json, written by `quest doctor` on success and failure.
import { z } from 'zod';

export const DoctorTool = z.object({
  name: z.string(),
  wanted: z.string(),
  resolved: z.string().nullable(),
  ok: z.boolean(),
  source: z.enum(['mise', 'toolchain']),
});
export type DoctorTool = z.infer<typeof DoctorTool>;

export const DoctorReport = z.object({
  checkedAt: z.iso.datetime(),
  tools: z.array(DoctorTool),
  configlet: z.object({ ok: z.boolean(), version: z.string().nullable() }),
});
export type DoctorReport = z.infer<typeof DoctorReport>;
