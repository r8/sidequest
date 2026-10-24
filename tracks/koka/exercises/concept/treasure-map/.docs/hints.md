# Hints

## General

- [The Koka book on pattern matching](https://koka-lang.github.io/koka/doc/book.html#sec-matching) covers `match`, guards and patterns.
- [The Koka book's tour of data types](https://koka-lang.github.io/koka/doc/book.html#sec-data-types) introduces the data types that patterns take apart.

## 1. Take a step

- Take the position apart in the parameter with `(x, y) : (int, int)`.
- `match` on the direction string, with `_` for the smudges.

## 2. Name the region

- Match on the whole position and use guards `| …` for the conditions.
- The branches are tried in order: the mountains come before the swamp.

## 3. Count the paces

- The steps east–west and north–south add up; `abs` makes a difference positive.

## 4. Read the clues aloud

- The patterns `[]`, `[x]` and `[x, y]` match lists of an exact length.
- `Cons(first, rest)` matches any non-empty list; `rest` has a `.length`.
