# Hints

## General

- [The Koka book on mutable variables](https://koka-lang.github.io/koka/doc/book.html#sec-var) explains `var` and
  `:=`.
- [The `std/core/list` documentation](https://koka-lang.github.io/koka/doc/std_core_list.html) describes
  `foreach` and `foreach-indexed`.

## 1. Add up the steps

- Keep a running total in a `var` and add each day to it in a `foreach`.

## 2. Count the good days

- An `if` without an `else` is fine when its branch only assigns a variable.

## 3. Find the longest streak

- Track two numbers as you go: the length of the current run, and the longest run so far.

## 4. Find the best day

- `foreach-indexed` gives each element's position, starting at 0.
- Only a strictly larger count should replace the record.

## 5. Plan the training

- Repeat "one more week" while the goal is not reached; the function's type will need the `div` effect.
