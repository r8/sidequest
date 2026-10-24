// A QuestError is an expected failure: cli.ts prints its message (no stack) and exits with its code.
export class QuestError extends Error {
  exitCode: number;
  constructor(message: string, exitCode = 1) {
    super(message);
    this.name = 'QuestError';
    this.exitCode = exitCode;
  }
}

/** Usage errors exit 2, like an unknown command. */
export function usage(message: string): QuestError {
  return new QuestError(message, 2);
}
