# Hints

## General

- [Bitwise operations](https://gforth.org/manual/Bitwise-operations.html) in the Gforth manual.
- [Number conversion](https://gforth.org/manual/Number-Conversion.html) explains the `%`, `$` and `#` prefixes.

## 1. Make the mask for a switch

- Start from the mask for switch 0 and shift it into place.

## 2. Check a switch

- Keep only the bit you care about, then turn what is left into a well-formed flag.

## 3. Turn a switch on

- Combine the settings with the mask so that a bit is set if it is set in either.

## 4. Turn a switch off

- A mask with every bit set _except_ one is the opposite of the mask from Task 1.

## 5. Flip a switch

- One of the bitwise words sets a bit of the result when it is set in exactly one of the two inputs.

## 6. Count the switches that are on

- A counted loop over the eight switch numbers can reuse Task 2.
