import { appendFileSync, existsSync, readFileSync } from 'node:fs';
import { availableParallelism } from 'node:os';
import { join } from 'node:path';
import { parseArgs } from 'node:util';
import { QuestError } from '../core/errors.ts';
import { bold, colorStatus, dim, red } from '../core/format.ts';
import { doneRecords } from '../core/done.ts';
import { repoRoot } from '../core/paths.ts';
import { select } from '../core/select.ts';
import { exerciseFiles, type Exercise } from '../core/track.ts';
import { workspaceDir } from '../core/workspace.ts';
import { runExercise } from '../runner/run.ts';
import type { CachedResult } from '../schema/results.ts';

export interface Outcome {
  exercise: Exercise;
  result: CachedResult | null;
  error: string | null; // tooling failure
  done: boolean;
}

function counts(result: CachedResult): { passed: number; total: number } {
  return { passed: result.tests.filter((t) => t.status === 'pass').length, total: result.tests.length };
}

function indent(text: string, by: string): string {
  return text.split('\n').map((l) => by + l).join('\n');
}

function report(outcome: Outcome, verbose: boolean): string {
  const ref = `${outcome.exercise.track.slug}/${outcome.exercise.slug}`;
  if (outcome.error) return `${bold(ref)}  ${red('tooling error')}\n${indent(outcome.error, '  ')}\n`;
  const r = outcome.result!;
  const { passed, total } = counts(r);
  let out = `${bold(ref)}  ${colorStatus(r.status)}  ${passed}/${total} passed  ${dim(`${r.durationMs} ms`)}\n`;
  if (r.message) out += indent(r.message, '  ') + '\n';
  for (const t of r.tests) {
    if (!verbose && t.status === 'pass') continue;
    const mark = t.status === 'pass' ? colorStatus('pass', '✓') : colorStatus(t.status, t.status === 'fail' ? '✗' : '!');
    out += `  ${mark} ${t.name}\n`;
    if (t.message) out += indent(t.message, '      ') + '\n';
    if (t.output && t.status !== 'pass') out += indent(t.output.trimEnd(), dim('      | ')) + '\n';
  }
  return out;
}

/**
 * What is wrong with a stub's run, or null: a stub must load and fail its tests. One that passes means
 * the tests can be met without solving anything; a run that errors, or reports no tests, did not run
 * them all against it (the stub does not load, or the run stopped partway).
 */
export function stubProblem(result: CachedResult): string | null {
  const why = result.message ? `: ${result.message.split('\n')[0]}` : '';
  if (result.status === 'pass') return 'the stub passes the tests';
  if (result.status === 'error') return `the run against the stub errored${why}`;
  if (!result.tests.length) return `no tests ran against the stub${why}`;
  return null;
}

/** One line per stub, with what is wrong if anything. */
function stubReport(outcome: Outcome): string {
  const ref = `${outcome.exercise.track.slug}/${outcome.exercise.slug}`;
  if (outcome.error) return `${bold(ref)}  ${red('tooling error')}\n${indent(outcome.error, '  ')}\n`;
  const problem = stubProblem(outcome.result!);
  const { passed, total } = counts(outcome.result!);
  return `${bold(ref)}  ${problem ? red(problem) : colorStatus('pass', 'fails as a stub should')}  ${passed}/${total} passed\n`;
}

/** One line when the workspace's copy of a test file differs from the track's. */
function testCopyNotice(root: string, exercise: Exercise): string | null {
  const ws = workspaceDir(root, exercise.track.slug, exercise.slug);
  const differs = exerciseFiles(exercise).test.filter((f) => {
    const mine = join(ws, f);
    const theirs = join(exercise.dir, f);
    return existsSync(mine) && existsSync(theirs) && !readFileSync(mine).equals(readFileSync(theirs));
  });
  if (!differs.length) return null;
  const ref = `${exercise.track.slug}/${exercise.slug}`;
  return `note: your copy of ${differs.join(', ')} differs from the track's; tests ran against the track's (\`quest start --refresh-tests ${ref}\` re-copies it)`;
}

const ICON: Record<string, string> = { pass: '✅ pass', fail: '❌ fail', error: '⚠️ error' };

export function summaryMarkdown(outcomes: Outcome[], title: string): string {
  const byTrack = new Map<string, Outcome[]>();
  for (const o of outcomes) byTrack.set(o.exercise.track.slug, [...(byTrack.get(o.exercise.track.slug) ?? []), o]);
  let md = `## ${title}\n\n`;
  if (!outcomes.length) return md + 'No exercises selected.\n\n';
  for (const [track, list] of byTrack) {
    md += `### ${list[0]!.exercise.track.config.language} (\`${track}\`)\n\n| Exercise | Status | Tests | Duration | Note |\n| --- | --- | --- | --- | --- |\n`;
    for (const o of list) {
      const cell = (s: string) => s.replace(/\|/g, '\\|').replace(/\n/g, ' ');
      if (o.error) {
        md += `| ${o.exercise.slug} | 🛠️ tooling error | | | ${cell(o.error.split('\n')[0]!)} |\n`;
        continue;
      }
      const r = o.result!;
      const { passed, total } = counts(r);
      const notes: string[] = [];
      if (o.done && r.status !== 'pass') notes.push('**done but failing**');
      if (r.status === 'error' && r.message) notes.push(cell(r.message.split('\n')[0]!));
      md += `| ${o.exercise.slug} | ${ICON[r.status]} | ${passed}/${total} | ${r.durationMs} ms | ${notes.join('; ')} |\n`;
    }
    md += '\n';
  }
  const n = (s: string) => outcomes.filter((o) => o.result?.status === s).length;
  const tooling = outcomes.filter((o) => o.error).length;
  md += `**Totals:** ${outcomes.length} exercise(s) · ${n('pass')} pass · ${n('fail')} fail · ${n('error')} error${tooling ? ` · ${tooling} tooling error` : ''}\n\n`;
  return md;
}

export default async function test(args: string[]): Promise<number> {
  const { values, positionals } = parseArgs({
    args,
    allowPositionals: true,
    options: {
      all: { type: 'boolean' },
      changed: { type: 'boolean' },
      base: { type: 'string' },
      'run-missing': { type: 'boolean' },
      examples: { type: 'boolean' },
      stubs: { type: 'boolean' },
      strict: { type: 'boolean' },
      'summary-md': { type: 'string' },
    },
  });
  const root = repoRoot();
  const examples = !!values.examples;
  const stubs = !!values.stubs;
  if (examples && stubs) throw new QuestError('--examples and --stubs cannot be combined', 2);
  const strict = examples || !!values.strict;
  const mode = examples ? 'examples' : stubs ? 'stubs' : 'workspace';
  const { exercises, notices } = select(root, {
    refs: positionals,
    all: values.all,
    changed: values.changed,
    base: values.base,
    runMissing: values['run-missing'],
    examples: examples || stubs,
  });
  for (const n of notices) process.stderr.write(`${n}\n`);
  if (!exercises.length) process.stdout.write('no exercises selected (no matching workspaces)\n');

  const done = doneRecords(root);
  const verbose = exercises.length === 1;
  const runOne = async (exercise: Exercise): Promise<Outcome> => {
    const ref = `${exercise.track.slug}/${exercise.slug}`;
    let outcome: Outcome;
    try {
      const result = await runExercise(root, exercise, mode);
      outcome = { exercise, result, error: null, done: done.has(ref) };
    } catch (err) {
      if (!(err instanceof QuestError)) throw err;
      outcome = { exercise, result: null, error: err.message, done: done.has(ref) };
    }
    let out = stubs ? stubReport(outcome) : report(outcome, verbose);
    const notice = mode === 'workspace' ? testCopyNotice(root, exercise) : null;
    if (notice) out += dim(notice) + '\n';
    process.stdout.write(out);
    return outcome;
  };
  // Tracks run side by side, as many at once as there are cores, and each track's exercises one after
  // another: runs of one track contend for its toolchain (and Koka's build directory), runs of different
  // tracks share nothing. Reports print as runs finish; outcomes keep the selection's order.
  const outcomes: Outcome[] = [];
  const lanes = [...Map.groupBy(exercises.entries(), ([, e]) => e.track.slug).values()];
  const lane = async () => {
    for (let next = lanes.shift(); next; next = lanes.shift()) {
      for (const [i, exercise] of next) outcomes[i] = await runOne(exercise);
    }
  };
  await Promise.all(Array.from({ length: Math.min(lanes.length, availableParallelism()) }, lane));

  if (exercises.length > 1) {
    const n = (s: string) => outcomes.filter((o) => o.result?.status === s).length;
    process.stdout.write(`\n${exercises.length} exercises: ${colorStatus('pass', `${n('pass')} pass`)}, ${colorStatus('fail', `${n('fail')} fail`)}, ${colorStatus('error', `${n('error')} error`)}\n`);
  }
  if (values['summary-md']) appendFileSync(values['summary-md'], summaryMarkdown(outcomes, examples ? 'Examples' : stubs ? 'Stubs' : 'Solutions'));

  if (outcomes.some((o) => o.error)) return 1;
  if (stubs) return outcomes.some((o) => stubProblem(o.result!)) ? 1 : 0;
  if (strict && outcomes.some((o) => o.result && o.result.status !== 'pass')) return 1;
  return 0;
}
