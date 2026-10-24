# Hints

## General

- [The Koka book on resuming](https://koka-lang.github.io/koka/doc/book.html#sec-resume) shows `ctl` clauses
  with and without `resume`.
- [Handling](https://koka-lang.github.io/koka/doc/book.html#sec-handling) shows a control operation used as an
  exception.

## 1. Attempt a room

- A clause that does not resume becomes the result of the whole handled block, so both have to be maybes.
- `final ctl` says the clause never resumes.

## 2. Give hints from the book

- `lookup` finds a puzzle's hint as a maybe; match on it.
- One branch resumes with the hint, the other ends the game.

## 3. Count the hints

- `override` lets the clause call `hint` itself, reaching the handler outside.
- `resume` returns the final pair of the handled block: take it apart, and return a new pair.
- What is the count when the action asks for no hints at all?

## 4. Play it strict

- The clause calls another operation instead of resuming.
- The action may give up on its own too, so its type includes `give-up`.
