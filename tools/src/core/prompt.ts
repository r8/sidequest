import { createInterface } from 'node:readline/promises';
import { QuestError } from './errors.ts';

/**
 * Asks a yes/no question. `--yes` answers it; without a TTY on stdin the command refuses rather than
 * prompt, so every command can run unattended.
 */
export async function confirm(question: string, yes: boolean | undefined, what: string): Promise<boolean> {
  if (yes) return true;
  if (!process.stdin.isTTY) throw new QuestError(`refusing to ${what} without --yes: stdin is not a terminal`);
  const rl = createInterface({ input: process.stdin, output: process.stdout });
  try {
    const answer = await rl.question(`${question} [y/N] `);
    return /^y(es)?$/i.test(answer.trim());
  } finally {
    rl.close();
  }
}
