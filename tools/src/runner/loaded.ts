// The source Node actually loaded for each module, recorded by a load hook. Node keeps a module for the
// life of the process, so this is the code that runs, even if the file has been edited since. It imports
// only builtins: the CLI registers the hook before it loads any of its own modules.
import { registerHooks } from 'node:module';
import { fileURLToPath } from 'node:url';

const loaded = new Map<string, Buffer>();
let recording = false;

export function recordLoadedSources(): void {
  if (recording) return;
  recording = true;
  registerHooks({
    load(url, context, nextLoad) {
      const result = nextLoad(url, context);
      // A module imported under a query (an adapter, keyed by its hash) is the same file.
      if (url.startsWith('file:') && result.source != null) loaded.set(fileURLToPath(url), Buffer.from(result.source as Uint8Array | string));
      return result;
    },
  });
}

/** The source this process loaded `path` from; undefined when it has not loaded it, or is not recording. */
export function loadedSource(path: string): Buffer | undefined {
  return loaded.get(path);
}
