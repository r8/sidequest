![Sidequest — branching paths through a world of programming discoveries](.github/assets/sidequest-banner.png)

# Sidequest

Learn five languages [Exercism](https://exercism.org) doesn't teach — Janet, Koka, Forth, BQN and Inko —
the way Exercism teaches the ones it does: short lessons that each introduce a concept, then practice
exercises with tests to make pass. Everything runs on your machine, and your progress is commits in your
own copy of this repository.

**145 lessons and 482 practice exercises.** No account, no server, no Docker: one CLI, `quest`, starts an
exercise, runs its tests, shows you an idiomatic solution to compare with, and marks it done.

> **Vibecoded.** The tooling, lessons, tests and reference solutions were generated with LLM coding
> agents, directed and reviewed by a human. Every reference solution passes its tests and every stub
> fails them, but the teaching text hasn't been proofread line by line: expect the odd mistake, and
> [see below](#how-this-was-made) for what is and isn't checked.

## The languages

| Language | What it teaches you | Lessons | Exercises |
| --- | --- | ---: | ---: |
| [Janet](https://janet-lang.org) | A small, practical Lisp: tables, fibers, PEG parsing, macros | 30 | 116 |
| [Koka](https://koka-lang.github.io) | Algebraic effects and handlers, pure functional data, reference counting without a GC | 29 | 106 |
| [Forth](https://gforth.org) | Thinking in stacks: words, stack effects, memory you manage yourself | 28 | 70 |
| [BQN](https://mlochbaum.github.io/BQN/) | Array programming: whole-array operations, tacit (point-free) style | 29 | 99 |
| [Inko](https://inko-lang.org) | Concurrency with actors and ownership types, `Result` and `Option` instead of exceptions | 29 | 91 |

Each language has its own *track*. A track opens with `hello-world`; lessons and exercises unlock as you
finish what they build on, so you can follow the syllabus or jump to the practice exercises.

## How it works

- **A lesson** teaches one or two concepts from scratch (`README.md` in your workspace), then gives you
  three to six small tasks, with hints if you get stuck.
- **A practice exercise** is a classic programming problem — leap years, run-length encoding, a zipper —
  with the test cases Exercism uses for every language, adapted to this one.
- You edit a stub, and `quest test` runs the track's own tests against it. Once they pass,
  `quest compare` shows an idiomatic reference solution next to yours, and `quest done` commits your
  solution with a record that it's finished.
- `quest dashboard` shows your progress in the browser: a concept map per track, every exercise's page,
  and a calendar of what you finished.

## Getting started

**1. Make your own copy.** Click **Use this template** on GitHub, then clone your new repository. Your
solutions are committed there, so keep it private if you'd rather not publish them.

**2. Install the prerequisites.** You need `git`, [Node](https://nodejs.org) 24.3 or newer and
[mise](https://mise.jdx.dev). On macOS or Linux (Windows: inside WSL2, with the repository cloned in the
WSL2 filesystem):

```sh
mise install          # Node, Janet, Koka and configlet, at pinned versions
npm ci
npx quest doctor      # says what's installed and what's missing
```

Three tracks need one tool from your system, at the version `quest doctor` asks for. You only need the
ones for the tracks you'll do:

| Track | Needs | Install |
| --- | --- | --- |
| Koka | a C compiler | `xcode-select --install` (macOS), `build-essential` (apt) |
| Forth | gforth 0.7.3 | `brew install gforth`, `apt-get install gforth` |
| BQN | CBQN at a pinned commit | clone and `make`, see [`tracks/bqn/docs/INSTALLATION.md`](tracks/bqn/docs/INSTALLATION.md) |
| Inko | Inko 0.21.1 (Linux, macOS 15+, FreeBSD) | `brew install inko`, AUR, Copr |

**3. Do your first exercise.**

```sh
npx quest start janet/hello-world          # creates solutions/janet/hello-world/
$EDITOR solutions/janet/hello-world/hello-world.janet
npx quest test janet/hello-world           # run the tests; repeat until they pass
npx quest compare janet/hello-world        # your solution next to the reference one
npx quest done janet/hello-world           # commit it as done
git push
```

`hello-world` unlocks the track's first lesson (`sourdough-schedule` for Janet) and most of its practice
exercises. `npx quest list janet` shows what's available, and for anything locked, what it waits on.

## Day to day

```sh
npx quest list [<track>]          # every exercise and its status
npx quest start <track>/<slug>    # stub, tests, README.md (instructions) and HELP.md into solutions/
npx quest test <track>/<slug>     # or a whole <track>, or --all
npx quest dashboard               # http://localhost:4321
npx quest help                    # every command and flag
```

- **Your workspace** is `solutions/<track>/<slug>/`: the file you edit, a copy of the tests to read, the
  instructions (`README.md`), how to run things and get help in that language (`HELP.md`), and a lesson's
  `HINTS.md`. Editing the test copy changes nothing: `quest test` always runs the track's own tests.
- **Done** means committed with a `.done.json` record. A solution you commit without `quest done` stays
  "passing", not done. Edit a done solution later and it stays done, marked "edited since".
- **Test results** are cached locally in `.cache/` (not committed). On a fresh clone, or another machine,
  `npx quest test --run-missing` rebuilds them.
- **Locked** exercises can be started anyway with `quest start --unlock <track>/<slug>`.
- Commands that ask for confirmation take `--yes`.

## Getting updates

A repository made from a template doesn't track it. To pull in new exercises and fixes later:

```sh
git remote add template https://github.com/r8/sidequest.git
git fetch template
git merge template/main --allow-unrelated-histories -X theirs   # the first time only
```

Your copy starts with a history of its own, so the first merge has nothing in common with the template
and would conflict on every file the template has changed since; `-X theirs` takes the template's
version there. After that, a plain `git fetch template && git merge template/main` is enough. Your work
is in `solutions/`, which the template doesn't have, so it is never touched.

## Adding exercises or a language

The tracks are standard Exercism tracks under `tracks/`, so new exercises come from Exercism's
[problem-specifications](https://github.com/exercism/problem-specifications):

```sh
npx quest new janet/raindrops --author <you>        # scaffold a practice exercise (Janet's tests are generated)
npx quest new janet/<slug> --concept <concept>      # scaffold a lesson
npx quest new-track <slug> --language <Name>        # a new language: a lint-clean track skeleton
npx quest validate                                  # configlet lint plus this project's checks
npx quest test --all --examples                     # every reference solution passes
npx quest test --all --stubs                        # every stub loads and fails
```

A new language is a `tracks/<track>/` directory, a mise pin (or a `quest.json` toolchain entry), one
TypeScript adapter in `tools/src/runners/`, and test fixtures. [`CLAUDE.md`](CLAUDE.md) describes how
everything fits together, how the lessons are written, and the steps for adding a track.

## Development

The `quest` CLI is TypeScript under `tools/`, run directly by Node, with `zod` as its only dependency.

```sh
npm run typecheck
npm test              # the tooling's own test suite
```

CI (`.github/workflows/ci.yml`) runs on every push: typecheck, the tooling tests, `quest validate`, every
reference solution and every stub, and a summary of your committed solutions. Failing solutions don't
fail the build.

## How this was made

Sidequest is vibecoded: its author directed and reviewed the work, and LLM agents (Claude Code, with
reviews by Codex) wrote it — the `quest` tooling, the lessons, the adapted tests, the stubs and the
reference solutions.

What is checked mechanically, on every push:

- every reference solution passes its exercise's tests, and every stub loads and fails them;
- `configlet lint` and the project's own checks pass on every track;
- the tooling's own test suite passes.

What isn't: whether the lessons' explanations and examples are right (a review found one Forth example
that computed 5 where the text said 4), whether a port of Exercism's test cases kept every case it should,
and whether the tests reject every plausible wrong solution. If something looks wrong, it may well be —
open an issue or fix it in your copy.

## License and credits

MIT; see [`LICENSE`](LICENSE). Exercise instructions and test cases come from Exercism's
[problem-specifications](https://github.com/exercism/problem-specifications), also MIT, with its notice
in [`NOTICE`](NOTICE) — keep both files in your copy. Each exercise credits it in
`.docs/instructions.append.md`. The lessons, tests, stubs, reference solutions and tooling were generated
for this project.
