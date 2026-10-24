# Hints

## General

- The manual's [tuples][tuples] page covers creating tuples and reading their values; [pattern matching][patterns]
  explains destructuring with `let`.

## 1. Mark a position

- A tuple is written as values between parentheses.

## 2. Shift a position

- Read the parts with `.0` and `.1`, add them up, and build a new tuple.

## 3. Count the steps between two stars

- The steps across and the steps up and down add up, and neither can be negative: `Int` has an `absolute` method.

## 4. Find the brighter star

- Compare the second values of the tuples, and return the first value of the winner.

## 5. Write a catalogue entry

- A single `let` with a nested pattern can take the whole star apart, position included.
- Floats can be interpolated into a string just like integers.

[tuples]: https://docs.inko-lang.org/manual/latest/getting-started/tuples/
[patterns]: https://docs.inko-lang.org/manual/latest/getting-started/pattern-matching/
