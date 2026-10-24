# Sidequest

A personal Exercism for languages Exercism does not have, in one git repository. Five tracks — Janet,
Koka, Forth, BQN, Inko — each with a syllabus of lessons (Exercism's concept exercises) and then practice
exercises: 145 lessons and 482 practice exercises in all. Content is in Exercism's track format under
`tracks/`; the learner's work is under `solutions/`; the `quest` CLI (TypeScript, run directly by Node)
starts, tests and completes exercises; a local dashboard shows progress.

The repository is a GitHub template: people make their own copy, learn there, and commit their
solutions to it. MIT (`LICENSE`); problem-specifications' notice is in `NOTICE`.

This file describes the project as it is. None of it is a rule: when something should change, change it
and update this file to match. Git history holds the reasons for past choices.

## Working on it

```sh
mise install && npm ci && npx quest doctor   # toolchains, dependencies, a check of both
npm run typecheck                            # tsc --noEmit
npm test                                     # the tooling suite (node --test over tools/test/*.test.ts)
npx quest validate                           # configlet lint + the project's own track checks
npx quest test --all --examples              # every example/exemplar must pass
npx quest test --all --stubs                 # every stub must load and fail its tests
```

- Before committing: typecheck, the tooling suite, and — when a change touches runners, harnesses or
  exercises — `--examples` and `--stubs` over the affected tracks (or `--all`; each takes a few minutes).
- Commits go straight to `main`, one logical change per commit. Subjects are short and say what is now
  true (`done: a failed commit leaves the exercise as it was`); bodies explain the problem, then a bullet
  list of what changed, file by file, ending with tests and docs.
- Never run `node --test` bare: `tools/test/fixtures/` holds exercise files that would be picked up.
  `npm test` targets the test files explicitly.
- Windows only through WSL2 (`.gitattributes` forces LF).

## Layout

```
tools/src/
  cli.ts          entry (mode 100755, the package's bin); dispatches to commands/
  commands/       one file per command; registry.ts holds the command table and usage text
  core/           tracks, workspaces, status, results cache, run keys, git, mise, selectors, authoring,
                  workspace docs, validation, colours, a small TOML reader
  runner/         staging, run-key inputs, ctx.exec, adapter loading, the shared harness mapper
  runners/        one adapter per track, found by file name: janet.ts koka.ts forth.ts bqn.ts inko.ts
  dashboard/      data.ts (buildData), render.ts (renderHtml, CSS and JS inline), markdown.ts, server.ts
  schema/         zod schemas: quest.json, Exercism configs, results, dashboard data
tools/test/       node:test suites; helpers.ts makes throwaway git repos driven through the real CLI;
                  fixtures/<runner>/run/<case>/ are golden tests for each adapter
tracks/<track>/   an Exercism track repository, plus quest.json
solutions/        the learner's workspaces; empty here, since copies of this template start from it
.cache/           gitignored: results/, staging/, build/<track>/ (Koka), toolchain/ (CI builds), doctor.json
dashboard/        gitignored: index.html from `quest dashboard --export`
```

TypeScript: native ESM on Node ≥ 24.3 with type stripping (`erasableSyntaxOnly`, so no enums, parameter
properties or runtime namespaces; `.ts` extensions on imports; `import type` for types). Runtime
dependency: `zod` only; dev: `typescript`, `@types/node`. git, mise, configlet and the toolchains are
driven through `child_process`. Every npm script is an alias `npx --no quest <name>` (`npm test` runs
`test:tools`). `npx` swallows `--help`, so help is `quest help`.

Code style: camelCase functions and variables, PascalCase types and zod schemas (a schema shares its
inferred type's name), UPPER_SNAKE constants, kebab-case multiword filenames. Expected failures throw
`QuestError` (printed without a stack; `usage()` exits 2, others 1); unexpected errors propagate. Each
module opens with a comment saying what it is for; comments explain why, briefly.

## Concepts

| Term | What it is | Where |
| --- | --- | --- |
| Track | One language, in Exercism's track layout | `tracks/<track>/` |
| Practice exercise | Instructions, stub, tests, example, `tests.toml` | `tracks/<track>/exercises/practice/<slug>/` |
| Lesson | Exercism's concept exercise: an introduction teaching one or two concepts, tasks, hints, stub, tests, exemplar | `tracks/<track>/exercises/concept/<slug>/`, concept docs in `tracks/<track>/concepts/<concept>/` |
| Workspace | The learner's copy: the stub (edited into the solution), a copy of the tests, `README.md`, `HELP.md` (and `HINTS.md` for a lesson) | `solutions/<track>/<slug>/` |
| Example | The reference solution (`files.example`; a lesson's `files.exemplar`, treated alike) | `.meta/` |
| Runner | A track's adapter: staged directory in, Exercism `results.json` v2 out | `tools/src/runners/<runner>.ts` |
| Result | `results.json` v2 plus `v`, `runKey`, `ranAt`, `durationMs`, `toolVersion` | `.cache/results/<track>/<slug>.json` |
| Done record | `{"done": "YYYY-MM-DD", "solution": "<sha256 of the solution files>"}` | `solutions/<track>/<slug>/.done.json` |

References are `<track>/<slug>` everywhere; a bare `<track>` selects a track (`quest test janet`).
Lessons come first (syllabus order), then practice exercises; slugs are unique across both.

### Status

Derived from the done records (committed) and the results cache (this machine):

1. `done` — the workspace has `.done.json`. Its cache status is kept alongside ("done but failing here").
   If the solution no longer hashes to the record, it stays done with "edited since".
2. `orphan` — a workspace for a slug `config.json` no longer lists. Shown; its result is ignored.
3. `available` / `locked` — no workspace yet; locked while any exercise in its `custom.after` is not done.
   `quest start` refuses a locked one (naming what it waits on); `--unlock` starts it anyway. Once started,
   an exercise is never locked.
4. `started` — a workspace with no cached result (every workspace on a fresh clone, until
   `quest test --run-missing`).
5. `passing` / `failing` — from a cached result whose `runKey` matches; a cached `error` is failing.
6. `stale` — a cached result whose `runKey` no longer matches.

### Done

`quest done <track>/<slug>` refuses unless the result is passing and current, prints the `compare` diff,
asks to confirm (`--yes` skips; without a TTY it refuses rather than prompts), re-checks against a fresh
read of everything the run key covers, writes `.done.json` (temp file + rename), then
`git add -- <workspace>` and `git commit --only -m "solve(<track>): <slug>" -- <workspace>`, leaving
anything else staged untouched. If either git step fails, the index and the previous `.done.json` (or
none) are restored. It does not push. A plain commit of a solution leaves it `passing`, not done.

## Track format

Each `tracks/<track>/` is an Exercism track repository and passes `configlet lint`: `config.json`,
`docs/` (the six files lint requires), `exercises/shared/.docs/` (`help.md`, `tests.md`, copied into
workspaces' `HELP.md`), `exercises/practice/`, `exercises/concept/`, `concepts/`. Per exercise,
`.meta/config.json` (authors, files, blurb, source) and `.meta/tests.toml` (canonical cases by UUID)
are Exercism's formats, written by `configlet create` and maintained by `configlet sync`.

- `files.*` templates use Exercism's placeholders (`%{kebab_slug}`, `%{snake_slug}`, `%{camel_slug}`,
  `%{pascal_slug}`). Janet and BQN: `<slug>.*` and `test/<slug>.*`. Koka and Forth: `test/<slug>-test.*`
  (both resolve an import of `<slug>` next to the importing file first, so a same-named test would import
  itself). Inko: `src/<snake_slug>.inko` and `test/test_<snake_slug>.inko`.
- `files.example[i]` pairs with `files.solution[i]` (`--examples` and `compare` rely on it).
- `"custom": { "after": [...] }` in every exercise's `.meta/config.json` is the order of the track:
  `[]` for `hello-world`, `["hello-world"]` for an exercise that builds on nothing else, and real
  build-ups otherwise (the simpler version of the same thing, an input another exercise produces, a
  structure another builds on). The graph is kept sparse, so most of a track opens after `hello-world`.
  `validate` rejects a missing `after`, unknown or duplicate slugs, self-reference and cycles. A lesson's
  Exercism `prerequisites` (concepts) are derived from its `after`, because `configlet lint` wants them;
  `validate --fix` writes them. Practice exercises' `practices` and `prerequisites` stay empty.
- `"custom": { "timeoutMs": n }` overrides the track's timeout for one exercise.
- An unfit canonical case is excluded in `tests.toml` with `include = false` and a `comment`.

**`quest.json`** — the one non-Exercism file, zod-validated (`schema/quest-json.ts`):

```json
{
  "runner": "janet",
  "harness": ["lib/test.janet"],
  "test": { "argv": ["janet", "{test}"], "env": { "JANET_PATH": "lib" }, "timeoutMs": 30000 },
  "toolchain": null,
  "color": "#9763cc"
}
```

- `runner` names `tools/src/runners/<runner>.ts`, whose default export is a `Runner`.
- `harness`: track-relative files every test needs; staged alongside and hashed into the run key.
- `test.argv` / `test.env`: run with `cwd` = the staging directory; `env` merges over `process.env`.
  `{test}` is the first `files.test` entry, `{tests}` all of them.
- `toolchain`: `null` when mise provides the tool; otherwise `bin`, `version`, `versionCommand`,
  `versionPattern`, optional `platforms`, and `ci` (`install`: argv lists; optional `image`).
- `color`: the track's dashboard colour. `new-track` picks the first unused of eighteen equal-lightness
  colours in `core/colors.ts` (the five tracks have the first five); without one, the dashboard derives
  one from the slug.

## Running tests

`quest test` stages into `mkdtemp` under `.cache/staging/`: the workspace's solution files, the track's
**canonical** test files and the harness, at track-relative paths. The workspace's test copy is never
used (`quest test` notes when it differs; `start --refresh-tests` re-copies). `--examples` stages the
example at the solution's path; `--stubs` the stub. Nothing in the workspace is modified by a run.

- **Runner interface** (`runner/types.ts`): `run(ctx)` gets `inputDir`, `outputDir`, `buildDir`
  (`.cache/build/<track>/`, persistent, only when the adapter sets `usesBuildDir` — Koka), `timeoutMs`,
  `testFiles`, `argv`, `env`, and `ctx.exec`. It writes `results.json` and does not throw on test
  failure. Optional `generateTests` (Janet only) and `lineComment` serve `quest new`.
- **`ctx.exec`** (`runner/exec.ts`) is the only way an adapter spawns: `mise exec --` for a mise track,
  the host binary for a toolchain track, or, when `CI=true` and the toolchain names `ci.image`,
  `docker run --rm` as the calling user with only the staging directory mounted. Children run detached;
  on timeout, or when quest gets SIGINT/SIGTERM/SIGHUP, their process groups (and containers) are killed.
  Output is capped per stream. A program that cannot be started is a `QuestError` (tooling failure), not
  a result.
- Runs for a `usesBuildDir` track hold `.cache/build/<track>.lock` (`core/lock.ts`: a directory holding
  a `<pid>-<uuid>` entry, taken by atomic rename). Tracks run side by side; exercises within a track one
  after another.
- **Shared harness protocol** (Janet, Koka, Forth, BQN): each harness under `tracks/<track>/lib/` prints
  `PASS|FAIL|ERROR<TAB>name<TAB>message<TAB>output` per test, each on a fresh line, then
  `SUMMARY<TAB>pass<TAB>fail<TAB>error`. `runner/harness.ts` maps it: no summary → `error` (the harness
  did not finish, e.g. the solution exited); summary counts that differ from the records read → `error`;
  zero tests → `error` ("no tests ran"); all passed but non-zero exit → `error`.
- **Inko** uses `std.test`, built with `inko build` from an adapter-generated main module whose reporter
  also names each passing test. Test names and order come from the test source; a declared test that
  did not run is an error. After a panic (uncatchable in Inko) the adapter reruns each test alone in one
  process, telling failures apart by name and panics by stack frame. Zero tests counted → `error`; tests
  counted but none with a literal name → pass with a warning. It is the largest adapter.
- Adapters strip ANSI codes; messages and outputs are truncated head+tail.
- Stubs fail per test with "implement me" in each language's idiom (Janet `(error "implement me")`, Koka
  `throw("implement me", ExnTodo)`, Forth `true abort" implement me"`, BQN `"implement me" ! 0`, Inko
  `panic('implement me')`). Typed stubs carry full signatures and the types the tests construct.

**Exit codes.** Without `--strict`, `quest test` exits non-zero only for tooling failures; failing
solutions are results. `--strict` (always on for `--examples`) also exits 1 on `fail`/`error`. `--stubs`
exits 1 unless every stub fails with tests reported.

**Selectors**: `<track>/<slug>`, `<track>`, `--all` (existing workspaces; every listed exercise under
`--examples`/`--stubs`), `--changed [--base <ref>]` (git diff plus untracked under `solutions/`, base
defaulting to the merge-base with `origin/HEAD`, falling back to `--all` with a notice), `--run-missing`.
`--summary-md <path>` appends a Markdown table per track (CI writes it to the job summary).

**Run key** (`core/runkey.ts`): sha256 over the staged solution, test and harness files (path + content,
sorted); the `test` block as the exercise runs it (placeholders filled, effective timeout); the resolved
tool version (mise's resolution, or what a toolchain's `versionCommand` reports now, observed once per
process); and the runner name with the source of the adapter as loaded (adapters are imported under a
content-hash URL). Anything else in the tooling is not in the key. `v` in the cached file lets a schema
change invalidate old results.

## Toolchains

`mise.toml` pins Node 24, Janet 1.42.1, Koka 3.2.9 and configlet 4.0.2, with `mise.lock` committed.
Forth (gforth 0.7.3), BQN (CBQN at a pinned commit) and Inko 0.21.1 come from the host and are pinned in
their `quest.json.toolchain`; `doctor` checks them, and `test`, `list`, `done` and the dashboard re-check
the version live (a mismatch stops that track's tests). Koka needs a C compiler. Inko runs on Linux,
macOS 15+ and FreeBSD (`platforms`). Install notes are in each track's `docs/INSTALLATION.md`.

`quest doctor` writes `.cache/doctor.json`, which the dashboard shows; nothing else trusts it.

## CI

`.github/workflows/ci.yml`, on every push and PR, Ubuntu, a two-entry matrix:

- both: checkout (shallow), mise (`--locked`), Node 24, `npm ci`, caches for `.cache/toolchain` and
  `.cache/build/koka`, `quest toolchain --install-ci` (gforth from apt, CBQN clone-and-make), `doctor`
  (Inko's version read inside `ghcr.io/inko-lang/inko:0.21.1`);
- `examples`: typecheck, tooling tests, `validate` (strict under `CI=true`), `test --all --examples`,
  and a summary of the committed solutions (failing solutions do not fail the build);
- `stubs`: `test --all --stubs`.

About seven to eight minutes; Koka compiling is most of it. `toolchain --install-ci` runs whatever argv
`quest.json` lists, with sudo, so the workflow should not run untrusted PRs with secrets.

## Dashboard

`quest dashboard` serves `http://localhost:4321` (`--port`) from `node:http`, building the page per
request (`buildData()` reads tracks, results, done records, `doctor.json` and git; `renderHtml()` is a
template string with CSS and JS inline and no external requests). `--export` writes the same page to
`dashboard/index.html`, which opens from `file://`. A malformed track answers 500 and the server keeps
serving; a malformed request target answers 400.

Tabs, kept in the URL hash (`#learn/koka/...`): **Overview** (status totals, per-track lessons and
practice done with bars, passing-here counts and toolchain, "In progress" across tracks, a three-month
completion calendar); **Learn** (per track: the syllabus as a concept map, a row per depth of the
lessons' `after`, links to direct build-ups only, each concept a page with its lesson, the practice
exercises after it, `about.md` and links; then the lessons table); **Practice** (per track: tiles easiest
first, coloured by status, and the table). Every exercise has a page with its next step, latest run,
rendered docs and folded hints. Each track's colour tints its tab, tiles and pages.

`dashboard/markdown.ts` renders the subset the docs use: headings, paragraphs, lists, fenced code, pipe
tables, Exercism admonitions (`~~~~exercism/note` and other kinds, as a titled box), inline code,
emphasis, inline and reference links (http(s) only; images become links). Everything is escaped first.

## Authoring

`quest new <track>/<slug>`: `configlet create --practice-exercise` (instructions, `.meta/config.json`,
`tests.toml`, the `config.json` entry), fetches `canonical-data.json` from problem-specifications over
HTTPS, writes the MIT attribution to `.docs/instructions.append.md` (editing `instructions.md` would show
as unsynced), an empty stub and example, and tests: generated by `generateTests` (Janet; a draft that
usually gets edited) or a skeleton of one TODO per included case. `--blank` for an original exercise,
`--after`, `--difficulty`, `--author`. `--concept <concept>,… --name <Name>` scaffolds a lesson instead.
`validate` reports any `TODO` left in a lesson's files.

Tracks grew by following a related Exercism track's practice exercises: Janet followed Scheme then Lua,
Koka Haskell, Forth 8th, BQN Uiua, Inko Rust. Tests are adapted to the language rather than ported
literally. Per-track data conventions:

- **Janet**: keywords for fixed sets, `make-<thing>` constructors returning a mutable table that module
  functions take first, kebab-case names (`isFoo` → `foo?`), core-shadowing names renamed (count→size).
  Strings are bytes, numbers doubles: big-number and Unicode-only cases excluded.
- **Koka**: algebraic types for fixed name sets, records as structs, `==` and `show` in the stub, pure
  data structures, arbitrary-precision `int`; stubs declare only `exn` (learners add `div`).
- **Forth**: invalid input throws -24; strings are `( c-addr u )`, returned strings live in a
  solution-owned buffer until the next call; arrays are `( addr n )` cell arrays; fixed sets are
  constants in the stub. The harness adds `assert-cells=` and `assert-xt-throws`. Unicode and numbers
  beyond a cell excluded.
- **BQN**: CamelCase functions, booleans 1/0, null `@`, maps as sorted key‿value lists; strings are code
  points, so Unicode cases stay.
- **Inko**: `Result` for errors, `Option` for missing values, `std.map.Map`, `mut` methods for stateful
  exercises, snake_case with `?` predicates; `String.chars` yields graphemes.
- Across tracks: canonical error messages; negative integer division rounds toward zero in the Forth
  and wordy examples; wordy's division by zero is the error "division by zero".

A fix to an example adds a test, marked "Not in the canonical data", that fails on the old example.

`quest validate` runs `configlet sync` in check mode: unsynced exercises (upstream cases added since)
are warnings; a sync check that could not run is a warning, and an error under `--strict`/`CI=true`.
`configlet sync --update --tests include` applies upstream cases to `tests.toml`; outside Janet the
test itself is then written by hand.

### Writing lessons

Each track has 28–30 lessons, from first steps to what the language is known for. As written so far:

- **Order**: the first lesson comes after `hello-world`; later ones name in `after` the lessons whose
  concepts they actually use, so the syllabus branches. About one practice exercise in ten names a
  lesson in its `after`.
- **One or two concepts per lesson**, each in the track's `concepts[]` and taught by exactly one lesson
  (`configlet lint` requires it).
- **Name** a short story name with the slug from it; the blurb says what it teaches through what.
- **`.docs/introduction.md`**: teaches the concepts from scratch, assuming only earlier lessons — what,
  syntax, short examples, pitfalls — 300–900 words, without solving the tasks. Code in it should run as
  shown.
- **`.docs/instructions.md`**: a short story, then three to six tasks `## 1. …`, each naming the function,
  its arguments and result, with an example call.
- **`.docs/hints.md`**: `## General` (links to official docs), then a nudge per task.
- **Stub, tests, exemplar**: the stub declares every task's function and fails like a practice stub; tests
  use the track harness, are named after their task (`"1. …"`), two to five per task; the exemplar is
  idiomatic and uses nothing from later lessons where avoidable.
- **`concepts/<concept>/`**: `introduction.md` (short, standalone), `about.md` (fuller reference),
  `links.json` (one to four official links), `.meta/config.json` with the blurb.
- Lesson text is original; one adapted from an Exercism concept exercise keeps `forked_from` and credits.
- A finished lesson is `validate --fix` clean, its exemplar passes and its stub fails.

### Adding a track

1. Toolchain: a `mise.toml` entry (registry, then `github:` backend, then cargo/npm/pipx), or a
   `quest.json.toolchain` with a `ci.install` recipe or `ci.image`. `mise install && quest doctor`.
2. `quest new-track <slug> --language <Name>` (`--ext`, `--solution`, `--test`, `--example`, `--runner`,
   `--tags`, `--indent-*`, `--color`): a lint-clean track with `hello-world` and `quest.json`.
3. A harness under `tracks/<track>/lib/` speaking the shared protocol, unless the language's own test
   facility reports every test machine-readably.
4. `tools/src/runners/<track>.ts`: run via `ctx.exec`, map output with `runner/harness.ts` (or by hand),
   set `usesBuildDir` for a compiled language. Golden fixtures under `tools/test/fixtures/<track>/run/`
   (pass, fail, error, load error, empty, no tests, timeout) — `runners.test.ts` picks them up by
   directory. `UPDATE_GOLDEN=1` rewrites expectations.
5. Exercises with `quest new`, then `quest test <track> --examples` and `--stubs`.

CI, `list` and the dashboard pick a new track up from `tracks/*/`. The test command gets nothing from
outside the staging directory except the toolchain and harness files (no network, no global package
cache), so a language with a package manager vendors into `lib/` or installs into `ctx.buildDir`.

## Open ends

- No exercise is done yet; `start`/`done`/`--changed` and the dashboard's done views are exercised by
  the tooling tests on throwaway repositories.
- Janet on Intel Mac / ARM Linux is untested (`janet.com` via `asset_pattern` is the likely route).
- Imported hello-world instructions still mention submitting on Exercism's website.
- `core/proc.ts`'s synchronous calls (version commands, configlet) have no timeout; the CI job has no
  `timeout-minutes`.
- Possible later: a GitHub Pages publish of `--export`; moving a track to its own repository with an
  Exercism test-runner image wrapping its adapter.
