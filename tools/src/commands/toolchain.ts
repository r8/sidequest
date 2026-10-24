import { parseArgs } from 'node:util';
import { usage } from '../core/errors.ts';
import { loadTracks } from '../core/track.ts';
import { passthrough } from '../core/proc.ts';
import { repoRoot } from '../core/paths.ts';

/** Runs every quest.json toolchain.ci.install recipe, in track order. A no-op until a track declares one. */
export default async function toolchain(args: string[]): Promise<number> {
  const { values } = parseArgs({ args, options: { 'install-ci': { type: 'boolean' } } });
  if (!values['install-ci']) throw usage('usage: quest toolchain --install-ci');
  const root = repoRoot();
  let ran = 0;
  for (const track of loadTracks(root)) {
    for (const argv of track.quest.toolchain?.ci.install ?? []) {
      process.stdout.write(`[${track.slug}] $ ${argv.join(' ')}\n`);
      const code = await passthrough(argv[0]!, argv.slice(1), { cwd: root });
      if (code !== 0) {
        process.stderr.write(`[${track.slug}] install step failed with exit code ${code}\n`);
        return 1;
      }
      ran++;
    }
  }
  process.stdout.write(ran ? `ran ${ran} install step(s)\n` : 'no track declares toolchain.ci.install; nothing to do\n');
  return 0;
}
