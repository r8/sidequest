// The README.md and HELP.md that `quest start` writes into a workspace, shaped like the ones the
// Exercism CLI downloads: the exercise's .docs/ and the track's shared .docs/, assembled under one title.
import { existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import type { Exercise, Track } from './track.ts';

export const README = 'README.md';
export const HELP = 'HELP.md';
export const HINTS = 'HINTS.md';

function read(path: string): string | null {
  return existsSync(path) ? readFileSync(path, 'utf8').trim() : null;
}

/** Pushes every heading down one level, outside fenced code blocks. */
function demote(markdown: string): string {
  let fenced = false;
  return markdown
    .split('\n')
    .map((line) => {
      if (/^\s*(```|~~~)/.test(line)) fenced = !fenced;
      return !fenced && /^#{1,5} /.test(line) ? `#${line}` : line;
    })
    .join('\n');
}

/** A document's body under a heading of our own: its leading `# Title` line goes, the rest is demoted. */
function section(heading: string, markdown: string | null): string[] {
  if (!markdown) return [];
  const body = markdown.replace(/^# [^\n]*\n+/, '');
  return [`## ${heading}`, demote(body)];
}

export function exerciseReadme(exercise: Exercise): string {
  const docs = join(exercise.dir, '.docs');
  const { meta } = exercise;
  const parts = [
    `# ${exercise.entry.name}`,
    `Welcome to ${exercise.entry.name} on the ${exercise.track.config.language} track.\nIf you need help running the tests or finishing the exercise, check out \`${HELP}\`.`,
    ...section('Introduction', read(join(docs, 'introduction.md'))),
    ...section('Instructions', read(join(docs, 'instructions.md'))),
  ];
  const append = read(join(docs, 'instructions.append.md'));
  if (append) parts.push(demote(append));
  parts.push('## Source');
  if (meta.authors.length) parts.push('### Created by', meta.authors.map((a) => `- @${a}`).join('\n'));
  if (meta.contributors?.length) parts.push('### Contributed to by', meta.contributors.map((a) => `- @${a}`).join('\n'));
  if (meta.source) parts.push('### Based on', meta.source_url ? `${meta.source} - ${meta.source_url}` : meta.source);
  return parts.join('\n\n') + '\n';
}

/** A lesson's hints, as the Exercism CLI downloads them; null for an exercise without .docs/hints.md. */
export function exerciseHints(exercise: Exercise): string | null {
  const hints = read(join(exercise.dir, '.docs', 'hints.md'));
  return hints && `${hints}\n`;
}

export function trackHelp(track: Track, slug: string): string {
  const shared = join(track.dir, 'exercises', 'shared', '.docs');
  const ref = `${track.slug}/${slug}`;
  // The shared docs are written for any exercise; here the exercise is known.
  const fill = (markdown: string | null) => markdown && markdown.replaceAll('<track>', track.slug).replaceAll('<slug>', slug);
  const parts = [
    '# Help',
    ...section('Running the tests', fill(read(join(shared, 'tests.md')))),
    '## Finishing the exercise',
    `Once the tests pass, \`npx quest compare ${ref}\` shows the track's example solution next to yours, and\n\`npx quest done ${ref}\` commits your workspace as done.`,
    ...section('Need to get help?', fill(read(join(shared, 'help.md')))),
  ];
  return parts.join('\n\n') + '\n';
}
