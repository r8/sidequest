# Hints

## General

- The manual's [pattern matching][patterns] page covers every kind of pattern used here.
- A match on an `Int` or a `String` always needs a final `_` case.

## 1. Assign a platform

- Match the line against string literals; `or` lets two lines share a case.

## 2. Show the delay

- Bind the delay to a name and use guards (`case d if d < 5 -> …`) for the ranges, trying them from small to
  large.

## 3. Choose the signal

- Match on the tuple `(clear, occupied)`. Use `_` for the value that doesn't matter.

## 4. Announce the next stop

- Match on `Some(stop)` and `None`.

## 5. Route a train

- A tuple pattern can contain a string literal and a `Some(…)` pattern at the same time. Order the cases from
  most to least specific.

## 6. Read a fare zone

- `strip_prefix('Z')` returns an option, and so does `Int.parse`. Unwrap each with `let Some(…) = … else return 0`.

[patterns]: https://docs.inko-lang.org/manual/latest/getting-started/pattern-matching/
