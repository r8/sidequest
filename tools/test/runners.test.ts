// Golden tests for every runner adapter: fixtures/<runner>/run/<case>/ holds the staged input/, the
// RunContext fields (ctx.json), the captured process output (exec.json: one result, or a list consumed
// in call order) and the expected results.json v2 (expected.json). UPDATE_GOLDEN=1 rewrites expectations.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { existsSync, mkdtempSync, readFileSync, readdirSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadRunner } from '../src/runner/load.ts';
import { Results } from '../src/schema/results.ts';
import type { ExecResult, RunContext } from '../src/runner/types.ts';
import type { Track } from '../src/core/track.ts';

const fixtures = fileURLToPath(new URL('./fixtures/', import.meta.url));

for (const runner of readdirSync(fixtures).sort()) {
  const runDir = join(fixtures, runner, 'run');
  if (!existsSync(runDir)) continue;
  for (const name of readdirSync(runDir).sort()) {
    test(`${runner} adapter maps the "${name}" fixture`, async () => {
      const dir = join(runDir, name);
      const fields = JSON.parse(readFileSync(join(dir, 'ctx.json'), 'utf8')) as { testFiles: string[]; argv: string[]; timeoutMs: number };
      const captured = JSON.parse(readFileSync(join(dir, 'exec.json'), 'utf8')) as ExecResult | ExecResult[];
      const queue = Array.isArray(captured) ? [...captured] : [captured];
      const outputDir = mkdtempSync(join(tmpdir(), `quest-${runner}-`));
      const ctx: RunContext = {
        track: {} as Track,
        slug: name,
        inputDir: join(dir, 'input'),
        outputDir,
        buildDir: join(outputDir, 'build'),
        timeoutMs: fields.timeoutMs,
        testFiles: fields.testFiles,
        argv: fields.argv,
        env: {},
        exec: async () => {
          const next = queue.shift();
          assert.ok(next, 'the adapter ran more processes than the fixture captured');
          return next;
        },
      };
      try {
        await (await loadRunner(runner)).runner.run(ctx);
        const actual = JSON.parse(readFileSync(join(outputDir, 'results.json'), 'utf8'));
        assert.ok(Results.safeParse(actual).success, 'results.json must match Exercism v2');
        const expectedPath = join(dir, 'expected.json');
        if (process.env.UPDATE_GOLDEN) writeFileSync(expectedPath, JSON.stringify(actual, null, 2) + '\n');
        assert.deepEqual(actual, JSON.parse(readFileSync(expectedPath, 'utf8')));
      } finally {
        rmSync(outputDir, { recursive: true, force: true });
      }
    });
  }
}
