# Hints

## General

- [General control structures with CASE](https://gforth.org/manual/General-control-structures-with-CASE.html) and [Selection](https://gforth.org/manual/Selection.html) in the Gforth manual.
- [CASE](https://forth-standard.org/standard/core/CASE) in the Forth standard, with examples.

## 1. Count the days in a month

- Only five months are not 31 days long; the 31-day months can all be the default.
- In the default branch, the month is still on the stack and `endcase` will drop it.

## 2. Read the rain gauge

- One `of` per code; the faulty gauge is the default.

## 3. Turn the page

- Only one month is special. The default computes the answer from the month, so it needs a copy of it.

## 4. Allow for leap years

- Only February cares about the flag; every other month must get rid of it.
- Task 1 already knows the lengths of the other months.
