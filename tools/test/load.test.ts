// Runner loading: the source returned with an adapter is the code that runs.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { rmSync, writeFileSync } from 'node:fs';
import { pathToFileURL } from 'node:url';
import { loadRunner, runnerPath, sharedModules } from '../src/runner/load.ts';
import { recordLoadedSources } from '../src/runner/loaded.ts';
import type { RunContext } from '../src/runner/types.ts';

test('an adapter edited after it was loaded is loaded again, with the edited source', async (t) => {
  const name = `__load-test-${process.pid}`;
  const path = runnerPath(name);
  t.after(() => rmSync(path, { force: true }));
  const adapter = (status: string) => `export default { async run() { return '${status}'; } };\n`;
  const ran = async (loaded: Awaited<ReturnType<typeof loadRunner>>) => (await loaded.runner.run({} as RunContext)) as unknown;

  writeFileSync(path, adapter('pass'));
  const first = await loadRunner(name);
  writeFileSync(path, adapter('fail'));
  const second = await loadRunner(name);

  assert.equal(await ran(first), 'pass');
  assert.equal(first.source.toString(), adapter('pass'));
  assert.equal(await ran(second), 'fail', 'Node must not hand back the first import');
  assert.equal(second.source.toString(), adapter('fail'));
});

test('an adapter runs with ctx.exec and the modules it imports at runtime, transitively', () => {
  const path = runnerPath('__shared-test');
  const source = [
    "import type { Runner } from '../runner/types.ts';",
    "import { truncate, type OUTPUT_LIMIT } from '../runner/output.ts';",
    "import {",
    "  isGroup,",
    "} from '../schema/canonical.ts';",
    "import { join } from 'node:path';",
  ].join('\n');
  const paths = sharedModules(path, Buffer.from(source)).map((m) => m.path).sort();
  assert.deepEqual(paths, ['core/errors.ts', 'runner/exec.ts', 'runner/output.ts', 'schema/canonical.ts']);
});

test('a shared module edited after the process loaded it is keyed by the source that runs', async (t) => {
  recordLoadedSources(); // as the CLI does first
  const name = `__race-test-${process.pid}`;
  const adapterPath = runnerPath(name);
  const sharedPath = runnerPath(`${name}-shared`);
  t.after(() => rmSync(adapterPath, { force: true }));
  t.after(() => rmSync(sharedPath, { force: true }));
  const shared = (value: string) => `export const value = '${value}';\n`;

  writeFileSync(sharedPath, shared('old'));
  await import(pathToFileURL(sharedPath).href); // loaded while the CLI starts up
  writeFileSync(sharedPath, shared('new')); // edited before the first adapter loads
  writeFileSync(adapterPath, `import { value } from './${name}-shared.ts';\nexport default { async run() { return value; } };\n`);
  const loaded = await loadRunner(name);

  assert.equal(await loaded.runner.run({} as RunContext), 'old');
  assert.equal(loaded.shared.find((m) => m.path === `runners/${name}-shared.ts`)?.source.toString(), shared('old'));
});
