// The Forth harness, run under the host's gforth (skipped when there is none).
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { cpSync, mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { repo } from './helpers.ts';

const hasGforth = spawnSync('gforth', ['--version']).status === 0;

test('assert-f~ passes within 0.01 and fails beyond it, and on NaN', { skip: !hasGforth }, (t) => {
  const dir = mkdtempSync(join(tmpdir(), 'quest-forth-'));
  t.after(() => rmSync(dir, { recursive: true, force: true }));
  mkdirSync(join(dir, 'test'));
  cpSync(join(repo, 'tracks/forth/lib'), join(dir, 'lib'), { recursive: true });
  writeFileSync(
    join(dir, 'test/floats.fs'),
    [
      'require ../lib/test.fs',
      'test" close"  1.504e 1.5e assert-f~ ;test',
      'test" far"  1.6e 1.5e assert-f~ ;test',
      'test" nan"  0e 0e f/ 1.5e assert-f~ ;test',
      'end-tests',
      '',
    ].join('\n'),
  );
  const run = spawnSync('gforth', ['test/floats.fs', '-e', 'bye'], { cwd: dir, encoding: 'utf8' });
  const records = run.stdout.split('\n').filter((line) => /^(PASS|FAIL|ERROR)\t/.test(line));
  // gforth prints NaN as "nan" or "-nan" depending on the platform's sign bit.
  assert.deepEqual(records.map((record) => record.replace('got -nan', 'got nan')), [
    'PASS\tclose\t\t',
    'FAIL\tfar\texpected 1.500000, got 1.600000\t',
    'FAIL\tnan\texpected 1.500000, got nan\t',
  ]);
  assert.equal(run.status, 1);
});

test('a test that changes either stack is an error, the same on every platform, and the depths are restored', { skip: !hasGforth }, (t) => {
  const dir = mkdtempSync(join(tmpdir(), 'quest-forth-'));
  t.after(() => rmSync(dir, { recursive: true, force: true }));
  mkdirSync(join(dir, 'test'));
  cpSync(join(repo, 'tracks/forth/lib'), join(dir, 'lib'), { recursive: true });
  writeFileSync(
    join(dir, 'test/stacks.fs'),
    [
      'require ../lib/test.fs',
      'test" leaks a float"  1.5e fdup 1.5e assert-f~ ;test',
      'test" takes a float"  fdrop ;test',
      'test" takes two floats"  fdrop fdrop ;test',
      'test" leaks on both"  1 2 0e ;test',
      'test" takes a cell"  drop ;test',
      'test" passes"  ;test',
      '.( DEPTHS ) depth . fdepth . cr',
      'end-tests',
      '',
    ].join('\n'),
  );
  const run = spawnSync('gforth', ['test/stacks.fs', '-e', 'bye'], { cwd: dir, encoding: 'utf8' });
  const records = run.stdout.split('\n').filter((line) => /^(PASS|FAIL|ERROR)\t/.test(line));
  assert.deepEqual(records, [
    'ERROR\tleaks a float\tthe test left the floating-point stack changed by 1 item(s)\t',
    'ERROR\ttakes a float\tthe test left the floating-point stack changed by -1 item(s)\t',
    'ERROR\ttakes two floats\tthe test left the floating-point stack changed by -2 item(s)\t',
    'ERROR\tleaks on both\tthe test left the stack changed by 2 item(s); the test left the floating-point stack changed by 1 item(s)\t',
    'ERROR\ttakes a cell\tthe test left the stack changed by -1 item(s)\t',
    'PASS\tpasses\t\t',
  ]);
  assert.match(run.stdout, /DEPTHS 0 0 /);
  assert.equal(run.status, 1);
});

test('a test that changes base, and throws, leaves the rest of the file and the summary in decimal', { skip: !hasGforth }, (t) => {
  const dir = mkdtempSync(join(tmpdir(), 'quest-forth-'));
  t.after(() => rmSync(dir, { recursive: true, force: true }));
  mkdirSync(join(dir, 'test'));
  cpSync(join(repo, 'tracks/forth/lib'), join(dir, 'lib'), { recursive: true });
  const passing = Array.from({ length: 9 }, (_, i) => `test" passes ${i}"  10 10 assert= ;test`);
  writeFileSync(
    join(dir, 'test/base.fs'),
    ['require ../lib/test.fs', 'test" octal and throws"  8 base ! -1 throw ;test', 'test" ten is ten"  10 5 2 * assert= ;test', ...passing, 'end-tests', ''].join('\n'),
  );
  const run = spawnSync('gforth', ['test/base.fs', '-e', 'bye'], { cwd: dir, encoding: 'utf8' });
  assert.match(run.stdout, /^PASS\tten is ten\t/m);
  assert.match(run.stdout, /^SUMMARY\t10\t0\t1$/m);
});
