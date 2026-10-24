import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { parseArgs } from 'node:util';
import { buildData } from '../dashboard/data.ts';
import { renderHtml } from '../dashboard/render.ts';
import { startServer } from '../dashboard/server.ts';
import { QuestError, usage } from '../core/errors.ts';
import { display, repoRoot } from '../core/paths.ts';

export default async function dashboard(args: string[]): Promise<number> {
  const { values } = parseArgs({ args, options: { export: { type: 'boolean' }, port: { type: 'string' } } });
  const root = repoRoot();
  if (values.export) {
    const file = join(root, 'dashboard', 'index.html');
    mkdirSync(join(root, 'dashboard'), { recursive: true });
    writeFileSync(file, renderHtml(buildData(root)));
    process.stdout.write(`wrote ${display(root, file)}\n`);
    return 0;
  }
  const port = Number(values.port ?? 4321);
  if (!Number.isInteger(port) || port < 0 || port > 65535) throw usage('--port must be a port number');
  try {
    const server = await startServer(root, port);
    const address = server.address();
    const actual = typeof address === 'object' && address ? address.port : port;
    process.stdout.write(`dashboard on http://localhost:${actual}/ (Ctrl-C to stop)\n`);
  } catch (err) {
    throw new QuestError(`cannot listen on port ${port}: ${(err as Error).message}`);
  }
  return new Promise<number>(() => {});
}
