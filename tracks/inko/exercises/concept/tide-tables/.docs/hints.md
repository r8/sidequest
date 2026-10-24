# Hints

## General

- The manual's [control flow][control-flow] page covers `while`, `loop`, `for`, `break` and `next`; the
  [ranges][range] module documents `until`, `to` and `step_by`.

## 1. Find the high water mark

- Keep the highest value seen so far in a `let mut` variable, and look at every reading with `for … in heights.iter`.

## 2. Count the hours above a level

- Count with a variable that goes up by one when a reading is high enough.

## 3. Find when a boat can come in

- Loop over the hours with a range up to the number of readings, and `return` as soon as you find a match.

## 4. Plan the readings

- A range made with `to` includes its end; `step_by` sets the interval. Push each value into a new array.

## 5. Find the longest safe stretch

- Track two numbers: the length of the current stretch and the longest one so far. A low reading ends the current
  stretch.

[control-flow]: https://docs.inko-lang.org/manual/latest/getting-started/control-flow/
[range]: https://docs.inko-lang.org/std/latest/module/std/range/
