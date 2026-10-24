// Exercise references are <track>/<slug> everywhere; a bare <track> selects a whole track.
import { usage } from './errors.ts';

export type Ref = { track: string; slug: string } | { track: string; slug: null };

const SLUG = /^[a-z0-9][a-z0-9-]*$/;

export function parseRef(text: string): Ref {
  const parts = text.replace(/\/+$/, '').split('/');
  if (parts.length === 1 && SLUG.test(parts[0]!)) return { track: parts[0]!, slug: null };
  if (parts.length === 2 && SLUG.test(parts[0]!) && SLUG.test(parts[1]!)) return { track: parts[0]!, slug: parts[1]! };
  throw usage(`"${text}" is not <track>/<slug> or <track>`);
}

export function parseExerciseRef(text: string | undefined, command: string): { track: string; slug: string } {
  if (!text) throw usage(`usage: quest ${command} <track>/<slug>`);
  const ref = parseRef(text);
  if (ref.slug === null) throw usage(`quest ${command} needs <track>/<slug>, not a bare track`);
  return ref;
}
