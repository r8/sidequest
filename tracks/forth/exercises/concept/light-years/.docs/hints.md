# Hints

## General

- [Double precision](https://gforth.org/manual/Double-precision.html) and [mixed precision](https://gforth.org/manual/Mixed-precision.html) in the Gforth manual.
- `d.` prints a double; `.s` shows its two cells, the high one on top.

## 1. Convert light years

- The product of two singles does not fit in one cell; one word multiplies them into a double.

## 2. Convert to metres

- Multiplying a double by a single fraction (here 1000/1) has its own word.

## 3. Plan a round trip

- A trip there and back is the distance added to itself; keep both cells together when you copy it.

## 4. Compare two destinations

- The standard double comparison is "less than"; swap the pair of doubles first.

## 5. Count the days

- The distance is never negative, so an unsigned division of a double by a single works; you want the quotient, not the remainder.
