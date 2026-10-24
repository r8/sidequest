// Shared pieces of `quest new` and `quest new-track`: problem-specifications data, tests.toml,
// and appending to a track's config.json.
import { readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { CanonicalData, isGroup, type CanonicalCase, type CanonicalNode } from '../schema/canonical.ts';
import { QuestError } from './errors.ts';
import { formatIssues } from './json.ts';
import { parseToml } from './toml.ts';

export const PROBLEM_SPECS = 'https://github.com/exercism/problem-specifications';
export const canonicalUrl = (slug: string) => `https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/${slug}/canonical-data.json`;

export async function fetchCanonical(slug: string): Promise<CanonicalData> {
  const url = canonicalUrl(slug);
  let res: Response;
  try {
    res = await fetch(url);
  } catch (err) {
    throw new QuestError(`could not fetch ${url}: ${(err as Error).message}`);
  }
  if (res.status === 404) throw new QuestError(`"${slug}" has no canonical data in problem-specifications (${url} is 404); use --blank for an original exercise`);
  if (!res.ok) throw new QuestError(`fetching ${url} failed: HTTP ${res.status}`);
  const parsed = CanonicalData.safeParse(await res.json());
  if (!parsed.success) throw new QuestError(formatIssues(url, parsed.error));
  return parsed.data;
}

export const ATTRIBUTION_FILE = 'instructions.append.md';

/**
 * The MIT attribution. It goes in .docs/instructions.append.md — Exercism's slot for track-specific
 * additions — because `configlet sync` reports instructions.md as unsynced if anything is appended to it.
 */
export function attribution(slug: string): string {
  return `# Attribution\n\nThe instructions and test cases of this exercise come from [exercism/problem-specifications](${PROBLEM_SPECS}/tree/main/exercises/${slug}), Copyright (c) 2021 Exercism, used under the MIT License.\n`;
}

export interface TestsToml {
  included: Set<string>;
  excluded: Set<string>;
}

export function readTestsToml(path: string): TestsToml {
  const doc = parseToml(readFileSync(path, 'utf8'));
  const included = new Set<string>();
  const excluded = new Set<string>();
  for (const [uuid, table] of doc) {
    if (!uuid) continue;
    (table.get('include') === false ? excluded : included).add(uuid);
  }
  return { included, excluded };
}

export interface FlatCase extends CanonicalCase {
  path: string[]; // the descriptions of enclosing groups
}

export function flattenCases(nodes: CanonicalNode[], path: string[] = []): FlatCase[] {
  return nodes.flatMap((node) => (isGroup(node) ? flattenCases(node.cases, [...path, node.description]) : [{ ...node, path }]));
}

/**
 * The canonical data reduced to the cases tests.toml includes; a case that another included case
 * reimplements is dropped in favour of the newer one.
 */
export function filterCanonical(data: CanonicalData, toml: TestsToml): CanonicalData {
  const included = (c: CanonicalCase) => toml.included.has(c.uuid) && !toml.excluded.has(c.uuid);
  const all = flattenCases(data.cases);
  const superseded = new Set(all.filter((c) => included(c) && c.reimplements).map((c) => c.reimplements!));
  const keep = (nodes: CanonicalNode[]): CanonicalNode[] =>
    nodes.flatMap((n): CanonicalNode[] => {
      if (isGroup(n)) {
        const cases = keep(n.cases);
        return cases.length ? [{ ...n, cases }] : [];
      }
      return included(n) && !superseded.has(n.uuid) ? [n] : [];
    });
  return { ...data, cases: keep(data.cases) };
}

/** The TODO skeleton used when the adapter has no generateTests. */
export function todoSkeleton(data: CanonicalData, slug: string, comment: string): string {
  const lines = [
    `${comment} Tests for ${slug}, from problem-specifications' canonical data.`,
    `${comment} Write one test per case below, then delete the TODO lines.`,
    '',
  ];
  for (const c of flattenCases(data.cases)) {
    lines.push(`${comment} TODO ${[...c.path, c.description].join(' > ')} [${c.uuid}]`);
    lines.push(`${comment}   ${c.property}(${JSON.stringify(c.input)}) => ${JSON.stringify(c.expected)}`);
  }
  return lines.join('\n') + '\n';
}

export function titleCase(slug: string): string {
  return slug
    .split('-')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
    .join(' ');
}

/** Appends a practice exercise entry to config.json, keeping Exercism's 2-space formatting. */
export function appendPracticeEntry(trackDir: string, entry: { slug: string; name: string; uuid: string; difficulty: number }): void {
  const file = join(trackDir, 'config.json');
  const config = JSON.parse(readFileSync(file, 'utf8')) as { exercises: { practice: unknown[] } };
  config.exercises.practice.push({ slug: entry.slug, name: entry.name, uuid: entry.uuid, practices: [], prerequisites: [], difficulty: entry.difficulty });
  writeFileSync(file, JSON.stringify(config, null, 2) + '\n');
}

/**
 * Adds a lesson to config.json: its entry, with prerequisites from `after` (the concepts those lessons
 * teach), any concept not yet listed, and status.concept_exercises.
 */
export function appendConceptEntry(trackDir: string, entry: { slug: string; name: string; uuid: string; concepts: string[]; after: string[] }, newConcepts: { slug: string; name: string; uuid: string }[]): void {
  const file = join(trackDir, 'config.json');
  const config = JSON.parse(readFileSync(file, 'utf8')) as {
    status?: Record<string, boolean>;
    exercises: { concept?: { slug: string; concepts: string[] }[] };
    concepts?: unknown[];
  };
  const lessons = (config.exercises.concept ??= []);
  const prerequisites = [...new Set(entry.after.flatMap((s) => lessons.find((l) => l.slug === s)?.concepts ?? []))];
  lessons.push({ slug: entry.slug, name: entry.name, uuid: entry.uuid, concepts: entry.concepts, prerequisites } as never);
  (config.concepts ??= []).push(...newConcepts.map((c) => ({ uuid: c.uuid, slug: c.slug, name: c.name })));
  if (config.status) config.status.concept_exercises = true;
  writeFileSync(file, JSON.stringify(config, null, 2) + '\n');
}

/** Sets an exercise's custom.after in its .meta/config.json, keeping the 2-space formatting. */
export function setAfter(exerciseDir: string, after: string[]): void {
  const file = join(exerciseDir, '.meta', 'config.json');
  const config = JSON.parse(readFileSync(file, 'utf8')) as { custom?: Record<string, unknown> };
  config.custom = { ...config.custom, after };
  writeFileSync(file, JSON.stringify(config, null, 2) + '\n');
}

export function setDifficulty(trackDir: string, slug: string, difficulty: number): void {
  const file = join(trackDir, 'config.json');
  const config = JSON.parse(readFileSync(file, 'utf8')) as { exercises: { practice: { slug: string; difficulty: number }[] } };
  const entry = config.exercises.practice.find((e) => e.slug === slug);
  if (entry && entry.difficulty !== difficulty) {
    entry.difficulty = difficulty;
    writeFileSync(file, JSON.stringify(config, null, 2) + '\n');
  }
}
