import { spawn, spawnSync } from 'node:child_process';

export interface ProcResult {
  code: number | null;
  stdout: string;
  stderr: string;
}

/** Runs a command to completion and captures its output. A missing binary yields code null with the error in stderr. */
export function capture(cmd: string, args: string[], opts: { cwd?: string; env?: NodeJS.ProcessEnv; input?: string } = {}): ProcResult {
  const r = spawnSync(cmd, args, { cwd: opts.cwd, env: opts.env, input: opts.input, encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 });
  if (r.error) return { code: null, stdout: '', stderr: r.error.message };
  return { code: r.status, stdout: r.stdout, stderr: r.stderr };
}

/** Runs a command with inherited stdio and resolves with its exit code. */
export function passthrough(cmd: string, args: string[], opts: { cwd?: string; env?: NodeJS.ProcessEnv } = {}): Promise<number> {
  return new Promise((resolve) => {
    const child = spawn(cmd, args, { cwd: opts.cwd, env: opts.env, stdio: 'inherit' });
    child.on('error', (err) => {
      process.stderr.write(`${cmd}: ${err.message}\n`);
      resolve(127);
    });
    child.on('close', (code) => resolve(code ?? 1));
  });
}

export function onPath(cmd: string): boolean {
  return capture('sh', ['-c', `command -v ${cmd}`]).code === 0;
}
