# Hints

## General

- [Counted loops](https://gforth.org/manual/Counted-loops-Tutorial.html) in the Gforth tutorial, and [Counted Loops](https://gforth.org/manual/Counted-Loops.html) in the reference.
- Write the stack before the loop and at the start of the body; the body must leave it the same way it found it, apart from the running total.

## 1. Knit a shawl

- Row number `n` has `n` stitches; the loop index can be the row number.
- A shawl of 0 rows has no stitches: make sure the loop can run zero times.

## 2. Knit a sleeve

- The extra stitches in a row depend on how far down the sleeve it is, which the loop index tells you.
- `start` is needed on every pass, so it has to stay on the stack under the total, or above it.

## 3. Knit a toe

- A loop can count down by any step, and when it counts down its limit is included.

## 4. Use up a ball of yarn

- On each pass, check whether the next row fits in what is left of the yarn.
- When it does not, the loop index is the answer; leave the word from inside the loop.

## 5. Plan a checked blanket

- One loop for the rows, one inside it for the squares of a row.
- A square is dark when its row and column are both even or both odd.
