# Hints

## General

- The manual's pages on [methods][methods] and [variables][variables] cover everything this lesson needs.
- Binary operators have no precedence in Inko: put parentheses around arithmetic that mixes them.

## 1. Know how long a firing takes

- A method returns the value of its last expression.
- A constant (a name starting with a capital letter, defined outside any method) is a good home for a number that
  never changes.

## 2. Work out how much of the firing is left

- Subtract the time already spent from the length of a firing; you can call `firing_minutes`, or use the constant.

## 3. Work out how long glazing takes

- Multiply the number of pieces by the minutes each one takes.

## 4. Work out the time spent so far

- Methods can call other methods of the same module: reuse `glazing_minutes`.

[methods]: https://docs.inko-lang.org/manual/latest/getting-started/methods/
[variables]: https://docs.inko-lang.org/manual/latest/getting-started/variables/
