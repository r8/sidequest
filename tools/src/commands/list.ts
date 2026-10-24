import { parseArgs } from 'node:util';
import { colorStatus, dim, table, bold } from '../core/format.ts';
import { repoRoot } from '../core/paths.ts';
import { parseRef } from '../core/refs.ts';
import { gitView, orphanTracks, trackStates, type ExerciseState } from '../core/status.ts';
import { findTrack, loadTracks } from '../core/track.ts';
import { usage } from '../core/errors.ts';

export function dateText(state: ExerciseState): string {
  if (!state.date) return '';
  if (state.date.kind === 'uncommitted') return 'uncommitted';
  return `${state.date.kind === 'done' ? 'done' : 'last changed'} ${state.date.value}`;
}

export function statusText(state: ExerciseState): string {
  const notes: string[] = [];
  if (state.status === 'done' && state.cacheStatus && state.cacheStatus !== 'passing') notes.push(`${colorStatus(state.cacheStatus)} here`);
  if (state.editedSinceDone) notes.push('edited since');
  if (state.status === 'locked') notes.push(`after ${state.waitingOn.join(', ')}`);
  const base = colorStatus(state.status);
  return notes.length ? `${base} (${notes.join(', ')})` : base;
}

export const RUN_MISSING_HINT = 'some workspaces have no result on this machine yet — run `quest test --run-missing`';

export default async function list(args: string[]): Promise<number> {
  const { positionals } = parseArgs({ args, allowPositionals: true, options: {} });
  if (positionals.length > 1) throw usage('usage: quest list [<track>]');
  const root = repoRoot();
  const git = gitView(root);
  let tracks;
  if (positionals[0]) {
    const ref = parseRef(positionals[0]);
    if (ref.slug !== null) throw usage('quest list takes a track, not an exercise');
    tracks = [findTrack(root, ref.track)];
  } else {
    tracks = loadTracks(root);
  }
  let missing = false;
  for (const track of tracks) {
    const states = trackStates(root, track, git);
    const listed = states.filter((s) => s.entry);
    const done = listed.filter((s) => s.status === 'done').length;
    process.stdout.write(`${bold(track.config.language)} ${dim(`(${track.slug})`)} — ${done}/${listed.length} done\n`);
    const rows = states.map((s) => [s.slug, statusText(s), s.entry?.kind === 'concept' ? 'lesson' : s.entry ? `d${s.entry.difficulty}` : '', dateText(s)]);
    if (rows.length) process.stdout.write(table(rows, '  ') + '\n');
    if (states.some((s) => s.status === 'started' || (s.status === 'done' && s.workspace && !s.result))) missing = true;
    process.stdout.write('\n');
  }
  if (!positionals[0]) {
    const stray = orphanTracks(root, tracks, git);
    if (stray.length) {
      process.stdout.write(`${bold('Orphans')} ${dim('(no such track)')}\n`);
      process.stdout.write(table(stray.map((s) => [`${s.track}/${s.slug}`, colorStatus('orphan'), '', dateText(s)]), '  ') + '\n\n');
    }
  }
  if (!tracks.length) process.stdout.write('no tracks under tracks/\n');
  if (missing) process.stdout.write(`${RUN_MISSING_HINT}\n`);
  return 0;
}
