// Runner discovery by file name: quest.json's `runner` names tools/src/runners/<runner>.ts. No registry.
import { createHash } from 'node:crypto';
import { existsSync, readFileSync } from 'node:fs';
import { dirname, relative, resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { QuestError } from '../core/errors.ts';
import type { SharedModule } from '../core/runkey.ts';
import { loadedSource } from './loaded.ts';
import type { Runner } from './types.ts';

const SRC = fileURLToPath(new URL('../', import.meta.url));
const EXEC = fileURLToPath(new URL('./exec.ts', import.meta.url));
// A relative import or re-export that is there at runtime: `import type` is erased.
const RUNTIME_IMPORT = /^(?:import|export)(?!\s+type\s)(?:[^'";]*?\sfrom)?\s*['"](\.{1,2}\/[^'"]+)['"]/gm;

export function runnerPath(name: string): string {
  return fileURLToPath(new URL(`../runners/${name}.ts`, import.meta.url));
}

/**
 * The code besides the adapter that decides what a run results in: ctx.exec's module and every module
 * the adapter imports, transitively, with paths relative to tools/src. `read` reads a module's source.
 */
export function sharedModules(adapterPath: string, adapterSource: Buffer, read: (path: string) => Buffer = readFileSync): SharedModule[] {
  const seen = new Map<string, Buffer>();
  const visit = (path: string, source: Buffer) => {
    for (const [, spec] of source.toString('utf8').matchAll(RUNTIME_IMPORT)) {
      const dep = resolve(dirname(path), spec!);
      if (seen.has(dep) || dep === adapterPath || !existsSync(dep)) continue;
      const depSource = read(dep);
      seen.set(dep, depSource);
      visit(dep, depSource);
    }
  };
  visit(adapterPath, adapterSource);
  if (!seen.has(EXEC)) {
    const execSource = read(EXEC);
    seen.set(EXEC, execSource);
    visit(EXEC, execSource);
  }
  return [...seen].map(([path, source]) => ({ path: relative(SRC, path), source }));
}

// Node imports a shared module once per process, so the source that runs is the one it loaded, which the
// CLI records. Without the recording (a test importing this module directly), or for a module not loaded
// yet, the first read stands in for it.
const firstRead = new Map<string, Buffer>();
function sourceThatRuns(path: string): Buffer {
  let source = loadedSource(path) ?? firstRead.get(path);
  if (!source) firstRead.set(path, (source = readFileSync(path)));
  return source;
}

/**
 * The adapter, the source it was loaded from, and the shared modules it runs with. Node keeps an
 * imported module for the life of the process, so the adapter is imported under a URL named by its
 * source's hash: the source returned is the code that runs, even if the file is edited during a batch
 * (the next load then imports the edit). The shared modules are not reloaded: those returned are the
 * sources this process loaded them from, as it runs them.
 */
export async function loadRunner(name: string): Promise<{ runner: Runner; source: Buffer; shared: SharedModule[] }> {
  const path = runnerPath(name);
  if (!existsSync(path)) throw new QuestError(`no runner adapter "${name}": expected tools/src/runners/${name}.ts`);
  for (;;) {
    const source = readFileSync(path);
    const url = `${pathToFileURL(path).href}?sha256=${createHash('sha256').update(source).digest('hex')}`;
    const mod = (await import(url)) as { default?: Runner };
    if (!readFileSync(path).equals(source)) continue; // edited while it loaded: load the edit
    if (!mod.default || typeof mod.default.run !== 'function') {
      throw new QuestError(`tools/src/runners/${name}.ts must default-export a Runner with run(ctx)`);
    }
    return { runner: mod.default, source, shared: sharedModules(path, source, sourceThatRuns) };
  }
}
