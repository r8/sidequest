# Hints

## General

- [Recursion](https://gforth.org/manual/Recursion-Tutorial.html) in the Gforth tutorial, and [`recurse`](https://forth-standard.org/standard/core/RECURSE) in the Forth standard.
- Write the base case first, and check that both branches leave what the stack effect says.

## 1. Count the arrangements

- The base case covers both 0 and 1, so compare with 2.
- The recursive case needs `n` twice: once to multiply, once to count down.

## 2. Count the layers

- The base case is a height below 1, which has no dolls; drop the height before leaving the answer.
- `*/` scales a number by a fraction.

## 3. Cut the blocks

- The base case leaves the width; the height of 0 has to go.
- The recursive call takes the height and the remainder, in that order; `tuck` is useful.

## 4. Count a family of dolls

- The recursive call needs `branching` and `depth - 1`; you also need a copy of `branching` afterwards to multiply by.
- Do not forget the doll on the outside.
