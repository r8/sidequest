// The runner contract is Exercism's test-runner interface: a staged solution directory in,
// <outputDir>/results.json out, exit cleanly whether or not the tests pass.
import type { Track } from '../core/track.ts';
import type { CanonicalData } from '../schema/canonical.ts';
import type { ExerciseConfig } from '../schema/exercise-config.ts';

export type ExerciseMeta = ExerciseConfig;

export interface ExecOptions {
  env?: Record<string, string>;
  cwd?: string;
  timeoutMs?: number;
}

export interface ExecResult {
  exitCode: number | null;
  stdout: string;
  stderr: string;
  timedOut: boolean;
}

export type Exec = (argv: string[], opts?: ExecOptions) => Promise<ExecResult>;

export interface RunContext {
  track: Track;
  slug: string;
  inputDir: string; // staged: solution files, canonical tests, harness, at track-relative paths
  outputDir: string; // where results.json must be written
  // .cache/build/<track>/, persistent across runs, for compiled languages: null unless the runner sets
  // usesBuildDir. Not mounted into a ci.image container, so only a host or mise toolchain can use it.
  buildDir: string | null;
  timeoutMs: number;
  testFiles: string[]; // the exercise's files.test, relative to inputDir
  argv: string[]; // quest.json test.argv with placeholders substituted
  env: Record<string, string>;
  // The only way an adapter runs a process. cwd defaults to inputDir; env merges over process.env.
  exec: Exec;
}

export interface Runner {
  run(ctx: RunContext): Promise<void>;
  // Whether run() uses ctx.buildDir. Runs of such a track take turns, in every quest process; runs of
  // other tracks share nothing and may overlap.
  usesBuildDir?: boolean;
  // Optional, for `quest new`: one rendered test file per path in files.test. `canonical` holds only
  // the cases tests.toml includes.
  generateTests?(canonical: CanonicalData, exercise: ExerciseMeta): Record<string, string>;
  // Optional, for `quest new`: the line-comment prefix used in the TODO test skeleton (default "#").
  lineComment?: string;
}
