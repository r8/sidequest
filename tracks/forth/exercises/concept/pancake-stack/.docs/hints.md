# Hints

## General

- The [Gforth tutorial](https://gforth.org/manual/Tutorial.html) walks through the stack, definitions and arithmetic.
- [Single precision](https://gforth.org/manual/Single-precision.html) in the Gforth manual lists the arithmetic words.
- Try each definition in `gforth` and use `.s` to see what it leaves.

## 1. Count the pancakes for a table

- Multiply first, then make sure the result is at least six; one of the words in the table picks the larger of two numbers.

## 2. Measure the stack

- Multiply by the thickness, then add the butter.

## 3. Fill the plates

- Integer division drops the remainder, which is what you want here.

## 4. Keep the spares

- The remainder of a division has its own word.

## 5. Plan the griddle

- Rounding a division up is the same as adding one less than the divisor before dividing.
