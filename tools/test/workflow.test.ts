// The learner workflow, end to end through the CLI on a throwaway repository.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { chmodSync, existsSync, readdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { exampleOf, tempRepo } from './helpers.ts';

test('start → test → done, and done refuses unless passing and fresh', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  assert.equal(r.quest(['start', '--unlock', 'janet/two-fer']).code, 0);
  assert.match(r.quest(['list', 'janet']).stdout, /two-fer\s+started\s+d1\s+uncommitted/);

  let done = r.quest(['done', 'janet/two-fer', '--yes']);
  assert.notEqual(done.code, 0);
  assert.match(done.stderr, /no test result/);

  const failing = r.quest(['test', 'janet/two-fer']);
  assert.equal(failing.code, 0, 'a failing solution is not a tooling failure');
  assert.match(failing.stdout, /janet\/two-fer\s+fail\s+0\/3 passed/);
  assert.equal(r.quest(['test', 'janet/two-fer', '--strict']).code, 1);
  done = r.quest(['done', 'janet/two-fer', '--yes']);
  assert.match(done.stderr, /do not pass/);

  r.write('solutions/janet/two-fer/two-fer.janet', exampleOf('janet', 'two-fer'));
  assert.match(r.quest(['list', 'janet']).stdout, /two-fer\s+stale/);
  done = r.quest(['done', 'janet/two-fer', '--yes']);
  assert.match(done.stderr, /stale/);

  assert.match(r.quest(['test', 'janet/two-fer']).stdout, /pass\s+3\/3 passed/);

  // An unrelated staged file must stay staged and out of the done commit.
  r.write('notes.txt', 'unrelated\n');
  r.git(['add', 'notes.txt']);
  const noTty = r.quest(['done', 'janet/two-fer']);
  assert.notEqual(noTty.code, 0);
  assert.match(noTty.stderr, /without --yes/);

  done = r.quest(['done', 'janet/two-fer', '--yes']);
  assert.equal(done.code, 0, done.stderr);
  assert.match(done.stdout, /git push/);
  const files = r.git(['show', '--name-only', '--format=%s', 'HEAD']).trim().split('\n').filter(Boolean);
  assert.deepEqual(files, [
    'solve(janet): two-fer',
    'solutions/janet/two-fer/.done.json',
    'solutions/janet/two-fer/HELP.md',
    'solutions/janet/two-fer/README.md',
    'solutions/janet/two-fer/test/two-fer.janet',
    'solutions/janet/two-fer/two-fer.janet',
  ]);
  assert.match(r.git(['diff', '--cached', '--name-only']), /^notes\.txt$/m);
  assert.match(r.quest(['list', 'janet']).stdout, /two-fer\s+done\s+d1\s+done \d{4}-\d\d-\d\d/);
  assert.match(r.read('solutions/janet/two-fer/.done.json'), /^\{\n  "done": "\d{4}-\d\d-\d\d",\n  "solution": "[0-9a-f]{64}"\n\}\n$/);

  // Still done after editing the solution, with a note; and after squashing history, which a commit
  // trailer would not have survived.
  r.write('solutions/janet/two-fer/two-fer.janet', exampleOf('janet', 'two-fer') + '\n# edited\n');
  assert.match(r.quest(['list', 'janet']).stdout, /two-fer\s+done \(stale here, edited since\)/);
  r.git(['checkout', '--', 'solutions/janet/two-fer/two-fer.janet']);
  r.git(['reset', '--soft', r.git(['rev-list', '--max-parents=0', 'HEAD']).trim()]);
  r.git(['commit', '-qm', 'squashed']);
  assert.match(r.quest(['list', 'janet']).stdout, /two-fer\s+done\s+d1/);
});

test('done works on a solution that was already committed', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  r.git(['add', '-A']);
  r.git(['commit', '-qm', 'plain commit']);
  r.quest(['test', 'janet/hello-world']);
  assert.match(r.quest(['list']).stdout, /hello-world\s+passing\s+d1\s+last changed \d{4}/);
  const done = r.quest(['done', 'janet/hello-world', '--yes']);
  assert.equal(done.code, 0, done.stderr);
  assert.match(r.quest(['list']).stdout, /hello-world\s+done/);
});

test('a done whose commit fails leaves the exercise, the index and HEAD as they were', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  r.quest(['test', 'janet/hello-world']);
  r.write('notes.txt', 'unrelated\n');
  r.git(['add', 'notes.txt']);
  const head = r.git(['rev-parse', 'HEAD']);
  const marker = 'solutions/janet/hello-world/.done.json';
  const unchanged = (done: { code: number | null; stderr: string }, why: RegExp) => {
    assert.equal(done.code, 1, done.stderr);
    assert.match(done.stderr, why);
    assert.equal(r.git(['rev-parse', 'HEAD']), head);
    assert.equal(r.git(['diff', '--cached', '--name-only']), 'notes.txt\n');
  };

  // A hook that rejects the commit.
  r.write('.git/hooks/pre-commit', '#!/bin/sh\nexit 1\n');
  chmodSync(join(r.root, '.git/hooks/pre-commit'), 0o755);
  unchanged(r.quest(['done', 'janet/hello-world', '--yes']), /git commit failed/);
  assert.equal(existsSync(join(r.root, marker)), false);
  assert.match(r.quest(['list', 'janet']).stdout, /hello-world\s+passing/);
  assert.match(r.quest(['start', 'janet/two-fer']).stderr, /locked until janet\/hello-world is done/);

  // An index lock held by someone else, so even git add fails.
  r.write('.git/index.lock', '');
  unchanged(r.quest(['done', 'janet/hello-world', '--yes']), /git add failed/);
  assert.equal(existsSync(join(r.root, marker)), false);
  rmSync(join(r.root, '.git/index.lock'));

  // Done again over an existing record: the old record comes back.
  rmSync(join(r.root, '.git/hooks/pre-commit'));
  assert.equal(r.quest(['done', 'janet/hello-world', '--yes']).code, 0);
  const committed = r.git(['rev-parse', 'HEAD']);
  const old = r.read(marker).replace(/"done": "[^"]+"/, '"done": "2020-01-01"');
  r.write(marker, old);
  r.write('.git/hooks/pre-commit', '#!/bin/sh\nexit 1\n');
  chmodSync(join(r.root, '.git/hooks/pre-commit'), 0o755);
  assert.equal(r.quest(['done', 'janet/hello-world', '--yes']).code, 1);
  assert.equal(r.git(['rev-parse', 'HEAD']), committed);
  assert.equal(r.read(marker), old);
});

test("changing an exercise's timeout makes its cached result stale", (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  r.quest(['test', 'janet/hello-world']);
  assert.match(r.quest(['list', 'janet']).stdout, /hello-world\s+passing/);
  const configPath = 'tracks/janet/exercises/practice/hello-world/.meta/config.json';
  const config = JSON.parse(r.read(configPath));
  r.write(configPath, JSON.stringify({ ...config, custom: { ...config.custom, timeoutMs: 1 } }));
  assert.match(r.quest(['list', 'janet']).stdout, /hello-world\s+stale/);
});

test("reordering an exercise's test files makes its cached result stale", (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  const configPath = 'tracks/janet/exercises/practice/hello-world/.meta/config.json';
  const config = JSON.parse(r.read(configPath));
  const withTests = (test: string[]) => r.write(configPath, JSON.stringify({ ...config, files: { ...config.files, test } }));
  r.write('tracks/janet/exercises/practice/hello-world/test/extra.janet', '(import test :as t)\n(t/run)\n');
  withTests([...config.files.test, 'test/extra.janet']);
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  r.quest(['test', 'janet/hello-world']);
  assert.match(r.quest(['list', 'janet']).stdout, /hello-world\s+passing/);
  // The same files in another order: {test} names the first, so another file would run now.
  withTests(['test/extra.janet', ...config.files.test]);
  assert.match(r.quest(['list', 'janet']).stdout, /hello-world\s+stale/);
});

test('the canonical tests decide, whatever the workspace copy says', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/test/hello-world.janet', '(import test :as t)\n(t/deftest "fake" (t/assert-true true))\n(t/run)\n');
  const out = r.quest(['test', 'janet/hello-world']);
  assert.match(out.stdout, /fail\s+0\/1 passed/);
  assert.match(out.stdout, /note: your copy of test\/hello-world\.janet differs/);
  assert.equal(r.quest(['start', 'janet/hello-world', '--refresh-tests']).code, 0);
  assert.doesNotMatch(r.quest(['test', 'janet/hello-world']).stdout, /note:/);
});

test('start writes README.md and HELP.md from the track docs; --refresh-tests rewrites them', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  assert.match(r.quest(['start', '--unlock', 'janet/hamming']).stdout, /read:\s+solutions\/janet\/hamming\/README\.md/);
  const readme = r.read('solutions/janet/hamming/README.md');
  assert.match(readme, /^# Hamming\n/);
  assert.match(readme, /\n## Introduction\n\nYour body is made up of cells/);
  assert.match(readme, /\n## Instructions\n\nCalculate the Hamming distance/);
  assert.match(readme, /\n## Attribution\n/, 'instructions.append.md headings are demoted under the title');
  assert.doesNotMatch(readme, /^# (Introduction|Instructions)$/m);
  assert.match(readme, /### Based on\n\nThe Calculating Point Mutations problem at Rosalind - https:\/\/rosalind\.info\/problems\/hamm\//);
  const help = r.read('solutions/janet/hamming/HELP.md');
  assert.match(help, /^# Help\n\n## Running the tests\n/);
  assert.match(help, /npx quest done janet\/hamming/);
  assert.doesNotMatch(help, /<slug>/, 'the shared docs\' placeholders are filled in');
  assert.match(help, /## Need to get help\?\n\nTo get help with Janet/);

  r.write('solutions/janet/hamming/README.md', 'scribbles');
  assert.equal(r.quest(['start', '--unlock', 'janet/hamming', '--refresh-tests']).code, 0);
  assert.equal(r.read('solutions/janet/hamming/README.md'), readme);
});

test('start refuses an existing workspace; --force --yes resets stub and tests', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', '--unlock', 'janet/leap']);
  r.write('solutions/janet/leap/leap.janet', 'my work');
  assert.notEqual(r.quest(['start', '--unlock', 'janet/leap']).code, 0);
  assert.match(r.quest(['start', '--unlock', 'janet/leap', '--force']).stderr, /without --yes/);
  assert.equal(r.read('solutions/janet/leap/leap.janet'), 'my work');
  assert.equal(r.quest(['start', '--unlock', 'janet/leap', '--force', '--yes']).code, 0);
  assert.equal(r.read('solutions/janet/leap/leap.janet'), exampleOf('janet', 'leap', 'leap.janet'));
});

test('--changed picks touched and never-committed workspaces, and degrades to --all without origin/HEAD', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.quest(['start', '--unlock', 'janet/leap']);
  r.git(['add', '-A']);
  r.git(['commit', '-qm', 'two workspaces']);
  r.git(['update-ref', 'refs/remotes/origin/main', 'HEAD']);
  r.git(['symbolic-ref', 'refs/remotes/origin/HEAD', 'refs/remotes/origin/main']);
  r.write('solutions/janet/leap/leap.janet', exampleOf('janet', 'leap'));
  r.quest(['start', '--unlock', 'janet/two-fer']); // never committed
  const changed = r.quest(['test', '--changed']);
  assert.match(changed.stdout, /janet\/leap\s+pass/);
  assert.match(changed.stdout, /janet\/two-fer\s+fail/);
  assert.doesNotMatch(changed.stdout, /hello-world/);

  r.git(['update-ref', '-d', 'refs/remotes/origin/HEAD']);
  const all = r.quest(['test', '--changed']);
  assert.match(all.stderr, /no origin\/HEAD/);
  assert.match(all.stdout, /hello-world/);
});

test('--run-missing runs only workspaces without a cached result', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.quest(['start', '--unlock', 'janet/leap']);
  r.quest(['test', 'janet/leap']);
  assert.match(r.quest(['list']).stdout, /quest test --run-missing/);
  const out = r.quest(['test', '--run-missing']);
  assert.match(out.stdout, /hello-world/);
  assert.doesNotMatch(out.stdout, /leap/);
  assert.doesNotMatch(r.quest(['list']).stdout, /--run-missing/);
});

test('--summary-md writes a table per track with done-but-failing noted', (t) => {
  const r = tempRepo();
  t.after(r.cleanup);
  r.quest(['start', 'janet/hello-world']);
  r.write('solutions/janet/hello-world/hello-world.janet', exampleOf('janet', 'hello-world'));
  r.quest(['test', 'janet/hello-world']);
  r.quest(['done', 'janet/hello-world', '--yes']);
  r.write('solutions/janet/hello-world/hello-world.janet', '(defn hello [] "Goodbye")');
  r.quest(['start', '--unlock', 'janet/leap']);
  const out = r.quest(['test', '--all', '--summary-md', 'summary.md']);
  assert.equal(out.code, 0);
  const md = r.read('summary.md');
  assert.match(md, /\| hello-world \| ❌ fail \| 0\/1 \| \d+ ms \| \*\*done but failing\*\* \|/);
  assert.match(md, /\| leap \| ❌ fail \| 0\/9 \|/);
  assert.match(md, /\*\*Totals:\*\* 2 exercise\(s\) · 0 pass · 2 fail · 0 error/);
  assert.match(r.quest(['list']).stdout, /hello-world\s+done \(failing here, edited since\)/);
  const staging = join(r.root, '.cache/staging');
  assert.ok(!existsSync(staging) || readdirSync(staging).length === 0, 'staging directories are removed after each run');
});
