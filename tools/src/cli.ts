#!/usr/bin/env node
// quest <command> [args] — dispatches to commands/<command>.ts.
import { recordLoadedSources } from './runner/loaded.ts';

// A run is keyed by the source of the modules its adapter runs with, as Node loaded them, so the hook
// that records them goes in before any other module of ours loads: they are all imported dynamically.
recordLoadedSources();
const { COMMANDS, usageText } = await import('./commands/registry.ts');
const { QuestError } = await import('./core/errors.ts');

const [name, ...args] = process.argv.slice(2);

// Output piped into something that stopped reading (`| head`) is not an error of ours.
process.stdout.on('error', (err: NodeJS.ErrnoException) => {
  if (err.code !== 'EPIPE') throw err;
  process.exit(process.exitCode ?? 0);
});

async function main(): Promise<number> {
  if (name === undefined || name === 'help' || name === '-h' || name === '--help') {
    process.stdout.write(usageText());
    return 0;
  }
  const command = COMMANDS.find((c) => c.name === name);
  if (!command) {
    process.stderr.write(`quest: unknown command "${name}"\n\n${usageText()}`);
    return 2;
  }
  const mod = (await import(`./commands/${command.file}.ts`)) as { default: (args: string[]) => Promise<number> };
  return mod.default(args);
}

try {
  process.exitCode = await main();
} catch (err) {
  if (err instanceof QuestError) {
    process.stderr.write(`quest ${name}: ${err.message}\n`);
    process.exitCode = err.exitCode;
  } else if (err instanceof TypeError && 'code' in err && String(err.code).startsWith('ERR_PARSE_ARGS')) {
    process.stderr.write(`quest ${name}: ${err.message}\n`);
    process.exitCode = 2;
  } else {
    throw err;
  }
}
