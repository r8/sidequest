// One test run: stage, compute the run key, call the track's adapter, read back results.json,
// and (for a workspace run) write the results cache.
import { existsSync, readFileSync, mkdirSync } from 'node:fs';
import { join } from 'node:path';
import { QuestError } from '../core/errors.ts';
import { formatIssues } from '../core/json.ts';
import { withLock } from '../core/lock.ts';
import { buildDir } from '../core/paths.ts';
import { writeResult } from '../core/results.ts';
import { computeRunKey, type Adapter } from '../core/runkey.ts';
import { toolVersion } from '../core/toolversion.ts';
import { exerciseFiles, timeoutFor, type Exercise } from '../core/track.ts';
import type { TestBlock } from '../schema/quest-json.ts';
import { CACHE_VERSION, Results, type CachedResult } from '../schema/results.ts';
import { makeExec } from './exec.ts';
import { runInputs, type Mode } from './inputs.ts';
import { loadRunner, runnerPath, sharedModules } from './load.ts';
import { stage } from './stage.ts';

export function substituteArgv(argv: string[], tests: string[]): string[] {
  return argv.flatMap((arg) => {
    if (arg === '{tests}') return tests;
    return [arg.replaceAll('{test}', tests[0] ?? '').replaceAll('{tests}', tests.join(' '))];
  });
}

// Null when the toolchain is unusable (not checked, or not the pinned version): `test` refuses to run
// then, so a result cached under the old version must not count as current either.
export function currentRunKey(root: string, exercise: Exercise, mode: Mode = 'workspace'): string | null {
  const tv = toolVersion(root, exercise.track);
  if (tv.problem || !tv.version) return null;
  return computeRunKey(runInputs(root, exercise, mode), testBlock(exercise), tv.version, adapterOf(exercise));
}

function adapterOf(exercise: Exercise): Adapter {
  const name = exercise.track.quest.runner;
  const path = runnerPath(name);
  if (!existsSync(path)) return { name, source: null, shared: [] };
  const source = readFileSync(path);
  return { name, source, shared: sharedModules(path, source) };
}

// The test block as this exercise runs it: the command with its test files substituted in order ({test}
// is the first, and the staged inputs are hashed sorted, so reordering files.test must show here) and
// the effective timeout, so changing custom.timeoutMs makes a cached result stale too.
function testBlock(exercise: Exercise): TestBlock {
  const { test } = exercise.track.quest;
  return { ...test, argv: substituteArgv(test.argv, exerciseFiles(exercise).test), timeoutMs: timeoutFor(exercise) };
}

export async function runExercise(root: string, exercise: Exercise, mode: Mode): Promise<CachedResult> {
  const { track } = exercise;
  const tv = toolVersion(root, track);
  if (tv.problem || !tv.version) throw new QuestError(`${track.slug}: ${tv.problem}`);
  const inputs = runInputs(root, exercise, mode);
  const { runner, source, shared } = await loadRunner(track.quest.runner);
  const staged = stage(root, `${track.slug}-${exercise.slug}`, inputs);
  let started = performance.now();
  try {
    // Keyed by the staged copies, which are what runs: an edit made meanwhile is in neither.
    const snapshot = inputs.map((input) => ({ ...input, source: join(staged.inputDir, input.path) }));
    const runKey = computeRunKey(snapshot, testBlock(exercise), tv.version, { name: track.quest.runner, source, shared });
    const tests = exerciseFiles(exercise).test;
    const timeoutMs = timeoutFor(exercise);
    const env = { ...track.quest.test.env };
    const go = (build: string | null) => {
      started = performance.now();
      return runner.run({
        track,
        slug: exercise.slug,
        inputDir: staged.inputDir,
        outputDir: staged.outputDir,
        buildDir: build,
        timeoutMs,
        testFiles: tests,
        argv: substituteArgv(track.quest.test.argv, tests),
        env,
        exec: makeExec({ track, inputDir: staged.inputDir, mountDir: staged.dir, timeoutMs, env }),
      });
    };
    if (runner.usesBuildDir) {
      // The build directory is shared by every run of the track, in every quest process: a compiled
      // language would otherwise pick up another run's output. Runs take turns.
      const build = buildDir(root, track.slug);
      mkdirSync(build, { recursive: true });
      await withLock(`${build}.lock`, () => go(build), () => process.stderr.write(`waiting for another quest run to finish with ${build}\n`));
    } else {
      await go(null);
    }
    const file = join(staged.outputDir, 'results.json');
    if (!existsSync(file)) throw new QuestError(`runner "${track.quest.runner}" wrote no results.json`);
    const parsed = Results.safeParse(JSON.parse(readFileSync(file, 'utf8')));
    if (!parsed.success) throw new QuestError(formatIssues(`runner "${track.quest.runner}" results.json`, parsed.error));
    const result: CachedResult = {
      v: CACHE_VERSION,
      runKey,
      ranAt: new Date().toISOString().replace(/\.\d{3}Z$/, 'Z'),
      durationMs: Math.round(performance.now() - started),
      toolVersion: tv.version,
      ...parsed.data,
    };
    if (mode === 'workspace') writeResult(root, track.slug, exercise.slug, result);
    return result;
  } finally {
    staged.cleanup();
  }
}
