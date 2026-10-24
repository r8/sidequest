export interface CommandInfo {
  name: string;
  file: string;
  usage: string;
  summary: string;
}

export const COMMANDS: CommandInfo[] = [
  { name: 'help', file: 'help', usage: 'help', summary: 'Show this usage' },
  { name: 'doctor', file: 'doctor', usage: 'doctor', summary: 'Check that every pinned toolchain is installed' },
  { name: 'list', file: 'list', usage: 'list [<track>]', summary: 'Exercises with their status' },
  { name: 'start', file: 'start', usage: 'start <track>/<slug> [--force [--yes]] [--refresh-tests] [--unlock]', summary: 'Create a workspace: the stub, the tests, README.md and HELP.md' },
  {
    name: 'test',
    file: 'test',
    usage: 'test <track>/<slug> | <track> | --all | --changed [--base <ref>] | --run-missing  [--examples | --stubs] [--strict] [--summary-md <path>]',
    summary: 'Run the canonical tests against a workspace',
  },
  { name: 'compare', file: 'compare', usage: 'compare <track>/<slug>', summary: 'Diff the solution against the example' },
  { name: 'done', file: 'done', usage: 'done <track>/<slug> [--yes]', summary: 'Commit a passing solution as done' },
  { name: 'new', file: 'new', usage: 'new <track>/<slug> [--blank | --concept <concept>,… [--name <name>]] [--author <name>] [--difficulty <n>] [--after <slug>,…]', summary: 'Scaffold an exercise from problem-specifications' },
  { name: 'new-track', file: 'new-track', usage: 'new-track <slug> --language <Name> [options]', summary: 'Scaffold a lint-clean track' },
  { name: 'validate', file: 'validate', usage: 'validate [<dir>] [--strict] [--fix]', summary: 'configlet lint plus this project\'s checks' },
  { name: 'cache', file: 'cache', usage: 'cache prune', summary: 'Delete cached results for unlisted exercises' },
  { name: 'toolchain', file: 'toolchain', usage: 'toolchain --install-ci', summary: 'Run every quest.json toolchain.ci.install recipe' },
  { name: 'dashboard', file: 'dashboard', usage: 'dashboard [--export] [--port <n>]', summary: 'Serve the progress dashboard on localhost:4321' },
  { name: 'typecheck', file: 'typecheck', usage: 'typecheck', summary: 'tsc --noEmit' },
  { name: 'test:tools', file: 'test-tools', usage: 'test:tools', summary: 'Run the tooling\'s node:test suite' },
];

export function usageText(): string {
  const width = Math.max(...COMMANDS.map((c) => c.name.length));
  const lines = COMMANDS.map((c) => `  ${c.name.padEnd(width)}  ${c.summary}\n  ${' '.repeat(width)}  quest ${c.usage}`);
  return `Usage: quest <command> [args]   (npx quest …, or npm run <command> -- …)\n\nCommands:\n${lines.join('\n')}\n`;
}
