# Hints

## General

- [Flags and comparisons](https://gforth.org/manual/Flags-and-Comparisons-Tutorial.html) in the Gforth tutorial.
- The Gforth manual's [numeric comparison](https://gforth.org/manual/Numeric-comparison.html) and [bitwise operations](https://gforth.org/manual/Bitwise-operations.html) pages list every word.

## 1. Check the height

- One comparison against the minimum is enough.

## 2. Check the seat

- There is a single word that checks a range, but mind which end of the range it includes.

## 3. Check the rider

- Each condition gives a flag; combine the two flags.
- The height is below the age on the stack: deal with the age first, then bring the height up.

## 4. Check the pair

- Either condition is enough. Alternatively, only the older rider matters.

## 5. Count the riders

- A true flag is the number -1, so the flags can be added.
