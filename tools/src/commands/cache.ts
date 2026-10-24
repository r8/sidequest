import { parseArgs } from 'node:util';
import { usage } from '../core/errors.ts';
import { display, repoRoot } from '../core/paths.ts';
import { deleteResult, listResults } from '../core/results.ts';
import { listedSlugs, loadTracks } from '../core/track.ts';

/** quest cache prune — deletes cached results for exercises no config.json lists any more. */
export default async function cache(args: string[]): Promise<number> {
  const { positionals } = parseArgs({ args, allowPositionals: true, options: {} });
  if (positionals[0] !== 'prune' || positionals.length > 1) throw usage('usage: quest cache prune');
  const root = repoRoot();
  const listed = new Set(loadTracks(root).flatMap((t) => listedSlugs(t).map((s) => `${t.slug}/${s}`)));
  let pruned = 0;
  for (const r of listResults(root)) {
    if (listed.has(`${r.track}/${r.slug}`)) continue;
    deleteResult(r.path);
    process.stdout.write(`pruned ${display(root, r.path)}\n`);
    pruned++;
  }
  process.stdout.write(pruned ? `pruned ${pruned} cached result(s)\n` : 'nothing to prune\n');
  return 0;
}
