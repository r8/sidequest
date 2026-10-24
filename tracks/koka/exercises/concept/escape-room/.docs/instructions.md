# Instructions

Ravi is the game master of The Locked Library, an escape room where teams have an hour to find the way out.
He is writing a simulator to try out new puzzles. A team's attempt at a room is an action that can use two
operations, declared for you in the stub:

```koka
pub effect ctl give-up(reason : string) : a

pub effect ctl hint(puzzle : string) : string
```

A team calls `give-up` when it has had enough — the game ends there — and `hint` to ask the game master for
help with a puzzle.

## 1. Attempt a room

Define the `attempt` function: it takes a team's action and runs it. It returns `Just` the action's result when
the team gets out, or `Nothing` if the team gives up.

```koka
attempt { "escaped" }
// => Just("escaped")

attempt { give-up("too dark") }
// => Nothing
```

## 2. Give hints from the book

Ravi keeps a hint book: a list of `(puzzle, hint)` pairs. Define the `with-hints` function: it takes the hint
book and an action, and runs the action, answering every `hint` with the book's hint for that puzzle. Asking for
a puzzle the book has no hint for ends the game. It returns `Just` the action's result, or `Nothing` if the game
ended.

```koka
with-hints([("clock", "it is always half past")]) { hint("clock") }
// => Just("it is always half past")

with-hints([("clock", "it is always half past")]) { hint("bookcase") }
// => Nothing
```

## 3. Count the hints

Define the `counting-hints` function: it takes an action and runs it, passing every `hint` on to the hint
handler outside it, and returns the action's result paired with the number of hints the team asked for.

```koka
with-hints([("clock", "half past"), ("safe", "1984")]) {
  counting-hints { hint("clock") ++ " " ++ hint("safe") }
}
// => Just(("half past 1984", 2))
```

## 4. Play it strict

In tournament mode there are no hints: asking for one means giving up. Define the `strict` function: it takes
an action and runs it, turning every `hint` into a `give-up` with the reason `"asked for a hint on <puzzle>"`.

```koka
attempt { strict { hint("safe") } }
// => Nothing
```
