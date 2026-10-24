// ctx.exec: every adapter process goes through here — `mise exec --` for a mise track, the host
// binary for a toolchain track, or `docker run` with only the staging directory mounted when a
// toolchain declares ci.image and CI=true. Detached, so a timeout or a cancelled quest kills the whole
// process group.
import { spawn, spawnSync } from 'node:child_process';
import { randomBytes } from 'node:crypto';
import { constants } from 'node:os';
import { QuestError } from '../core/errors.ts';
import type { Track } from '../core/track.ts';
import { stripAnsi } from './output.ts';
import type { Exec, ExecResult } from './types.ts';

// Per stream, in UTF-16 code units: what a runaway test prints past it is dropped.
const OUTPUT_CAP = 16 * 1024 * 1024;

export interface ExecConfig {
  track: Track;
  inputDir: string;
  /** The directory mounted into a ci.image container. */
  mountDir: string;
  timeoutMs: number;
  env: Record<string, string>;
  /** Whether this is CI, where a toolchain's ci.image applies. Defaults to CI=true in the environment. */
  ci?: boolean;
}

/** The image an argv runs in: the toolchain's ci.image, under CI only. */
function imageFor(config: ExecConfig): string | null {
  const image = config.track.quest.toolchain?.ci.image;
  return image && (config.ci ?? process.env.CI === 'true') ? image : null;
}

/** The argv actually spawned for an adapter's argv; `container` names the container of an image run. */
export function wrapArgv(config: ExecConfig, argv: string[], cwd: string, env: Record<string, string>, container?: string): string[] {
  const tc = config.track.quest.toolchain;
  if (tc === null) return ['mise', 'exec', '--', ...argv];
  const image = imageFor(config);
  if (image) {
    const envArgs = Object.entries(env).flatMap(([k, v]) => ['-e', `${k}=${v}`]);
    // Run as the calling user, so files the tests write into the mounted staging directory can be
    // cleaned up afterwards; HOME then has to be somewhere that user can write.
    const user = process.getuid && process.getgid ? ['--user', `${process.getuid()}:${process.getgid()}`, '-e', 'HOME=/tmp'] : [];
    const name = container ? ['--name', container] : [];
    return ['docker', 'run', '--rm', ...name, ...user, '-v', `${config.mountDir}:${config.mountDir}`, '-w', cwd, ...envArgs, image, ...argv];
  }
  return argv;
}

// What to stop for each running child. Children run detached, in their own process group, so the
// terminal's Ctrl-C never reaches them: a cancelled quest stops them itself before it exits.
const running = new Set<() => void>();
let cancellable = false;

function onCancel(signal: NodeJS.Signals): void {
  for (const stop of running) stop();
  process.exit(128 + constants.signals[signal]);
}

/**
 * Runs argv detached and kills its process group on timeout, or when quest itself is interrupted or
 * terminated; `onKill` then cleans up what lives outside the group (a container). A program that
 * cannot be started at all rejects with a QuestError: that is a broken toolchain, not a result.
 */
export function spawnWithTimeout(argv: string[], opts: { cwd: string; env: NodeJS.ProcessEnv; timeoutMs: number; onKill?: () => void }): Promise<ExecResult> {
  return new Promise((resolve, reject) => {
    const child = spawn(argv[0]!, argv.slice(1), { cwd: opts.cwd, env: opts.env, detached: true, stdio: ['ignore', 'pipe', 'pipe'] });
    let stdout = '';
    let stderr = '';
    let timedOut = false;
    const killGroup = () => {
      try {
        if (child.pid) process.kill(-child.pid, 'SIGKILL');
      } catch {
        // already gone
      }
    };
    child.stdout.setEncoding('utf8').on('data', (d: string) => {
      stdout += d.slice(0, OUTPUT_CAP - stdout.length);
    });
    child.stderr.setEncoding('utf8').on('data', (d: string) => {
      stderr += d.slice(0, OUTPUT_CAP - stderr.length);
    });
    const stop = () => {
      killGroup();
      opts.onKill?.();
    };
    if (!cancellable) {
      cancellable = true;
      for (const signal of ['SIGINT', 'SIGTERM', 'SIGHUP'] as const) process.once(signal, onCancel);
    }
    running.add(stop);
    const timer = setTimeout(() => {
      timedOut = true;
      stop();
    }, opts.timeoutMs);
    // Stragglers the test left in the background would hold the pipes open: reap the group on exit.
    child.on('exit', killGroup);
    child.on('error', (err) => {
      clearTimeout(timer);
      running.delete(stop);
      reject(new QuestError(`could not start ${argv[0]}: ${err.message}; is it installed? \`quest doctor\` checks every toolchain`));
    });
    child.on('close', (code) => {
      clearTimeout(timer);
      running.delete(stop);
      resolve({ exitCode: timedOut ? null : code, stdout, stderr, timedOut });
    });
  });
}

/**
 * What mise said when it failed before the program it wraps ran (the program missing, say), or null.
 * mise replaces itself with the program, so such a failure leaves only mise's own lines on stderr.
 */
export function miseFailure(r: ExecResult): string | null {
  if (r.timedOut || r.exitCode === 0 || r.stdout) return null;
  const first = stripAnsi(r.stderr).split('\n').find((line) => !line.startsWith('mise WARN'));
  return /^mise ERROR (.*)$/.exec(first ?? '')?.[1] ?? null;
}

export function makeExec(config: ExecConfig): Exec {
  return async (argv, opts = {}) => {
    const cwd = opts.cwd ?? config.inputDir;
    const env = { ...config.env, ...opts.env };
    // A killed `docker run` leaves its container running; name it so a timeout can remove it.
    const container = imageFor(config) ? `quest-${randomBytes(6).toString('hex')}` : undefined;
    const onKill = container ? () => void spawnSync('docker', ['rm', '--force', container], { stdio: 'ignore' }) : undefined;
    const result = await spawnWithTimeout(wrapArgv(config, argv, cwd, env, container), { cwd, env: { ...process.env, ...env }, timeoutMs: opts.timeoutMs ?? config.timeoutMs, onKill });
    const failure = config.track.quest.toolchain === null ? miseFailure(result) : null;
    if (failure) throw new QuestError(`mise could not start ${argv[0]}: ${failure}; is it installed? \`quest doctor\` checks every toolchain`);
    return result;
  };
}
