// Selectors for `quest test`: <track>/<slug>, <track>, --all, --changed [--base], --run-missing.
// A track or --all means workspaces that exist — except under --examples or --stubs, which mean every listed
// exercise (the caller passes either as `examples`).
import { existsSync } from 'node:fs';
import { QuestError, usage } from './errors.ts';
import { changedPaths, defaultBase } from './git.ts';
import { parseRef } from './refs.ts';
import { readResult } from './results.ts';
import { findTrack, listedSlugs, loadExercise, loadTracks, type Exercise, type Track } from './track.ts';
import { listWorkspaces, workspaceDir } from './workspace.ts';

export interface SelectOptions {
  refs: string[];
  all?: boolean | undefined;
  changed?: boolean | undefined;
  base?: string | undefined;
  runMissing?: boolean | undefined;
  examples?: boolean | undefined;
}

export interface Selection {
  exercises: Exercise[];
  notices: string[];
}

export function select(root: string, opts: SelectOptions): Selection {
  if (!opts.refs.length && !opts.all && !opts.changed && !opts.runMissing) {
    throw usage('nothing selected: give <track>/<slug>, <track>, --all, --changed or --run-missing');
  }
  const notices: string[] = [];
  const tracks = new Map<string, Track>();
  const track = (slug: string) => {
    let t = tracks.get(slug);
    if (!t) tracks.set(slug, (t = findTrack(root, slug)));
    return t;
  };
  const picked = new Map<string, Exercise>();
  const add = (t: Track, slug: string) => {
    const key = `${t.slug}/${slug}`;
    if (!picked.has(key)) picked.set(key, loadExercise(t, slug, root));
  };
  const hasWorkspace = (t: Track, slug: string) => existsSync(workspaceDir(root, t.slug, slug));
  const addTrack = (t: Track) => {
    for (const slug of listedSlugs(t)) if (opts.examples || hasWorkspace(t, slug)) add(t, slug);
  };

  if (opts.changed) {
    const base = opts.base ?? defaultBase(root);
    if (!base) {
      notices.push('--changed: no origin/HEAD to compare against; testing every workspace (--all)');
      opts = { ...opts, all: true };
    } else {
      for (const path of changedPaths(root, base)) {
        const [, t, slug] = path.split('/');
        if (!t || !slug) continue;
        let tr: Track;
        try {
          tr = track(t);
        } catch {
          continue;
        }
        if (listedSlugs(tr).includes(slug) && (opts.examples || hasWorkspace(tr, slug))) add(tr, slug);
      }
    }
  }

  for (const text of opts.refs) {
    const ref = parseRef(text);
    const t = track(ref.track);
    if (ref.slug === null) {
      addTrack(t);
    } else {
      if (!opts.examples && !hasWorkspace(t, ref.slug)) {
        if (!listedSlugs(t).includes(ref.slug)) loadExercise(t, ref.slug, root); // throws "not listed"
        throw new QuestError(`no workspace for ${t.slug}/${ref.slug}; run \`quest start ${t.slug}/${ref.slug}\` first`);
      }
      add(t, ref.slug);
    }
  }

  if (opts.all) for (const t of loadTracks(root)) addTrack(tracks.get(t.slug) ?? (tracks.set(t.slug, t), t));

  if (opts.runMissing) {
    for (const t of loadTracks(root)) {
      const tr = tracks.get(t.slug) ?? (tracks.set(t.slug, t), t);
      const listed = new Set(listedSlugs(tr));
      for (const ws of listWorkspaces(root, tr.slug)) {
        if (listed.has(ws.slug) && !readResult(root, tr.slug, ws.slug)) add(tr, ws.slug);
      }
    }
  }
  return { exercises: [...picked.values()], notices };
}
