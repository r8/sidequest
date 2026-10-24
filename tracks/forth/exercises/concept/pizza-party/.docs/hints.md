# Hints

## General

- [Floating point](https://gforth.org/manual/Floating-Point.html) in the Gforth manual lists every float word, and the [tutorial](https://gforth.org/manual/Floating-Point-Tutorial.html) introduces them.
- Use `f.s` in `gforth` to see the float stack, and `.s` for the data stack.

## 1. Work out the area of a pizza

- The radius is half the diameter; `pi` pushes π onto the float stack.

## 2. Work out the area of a slice

- The slice count is an integer on the data stack; it has to move to the float stack before you can divide by it.

## 3. Compare two offers

- Factor out a word that turns a diameter and a price into a price per area.
- `frot` brings the third float up, which helps reach the first pizza once the second has been dealt with.

## 4. Order enough pizza

- Multiply first, then round up; `floor` rounds down, and rounding `-x` down is rounding `x` up, negated.
- `f>s` moves the result to the data stack.

## 5. Leave a tip

- 15% is `0.15e`; `fround` rounds to the nearest whole number.
