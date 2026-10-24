# Hints

## General

- [Stack manipulation](https://gforth.org/manual/Stack-Manipulation-Tutorial.html) in the Gforth tutorial, and the [reference](https://gforth.org/manual/Data-stack.html) with every shuffling word.
- Write the stack after each word as a comment while you work; check it with `.s` in `gforth`.

## 1. Measure the stage

- The side is needed twice.

## 2. Count the balls in hand

- Both results need both numbers: keep a copy of the pair before using it.
- The sum ends up below the difference, so it has to be moved out of the way.

## 3. Measure a pass

- Work out one squared difference, park it out of the way with a shuffle, then work out the other.
- Squaring a difference is the same as Task 1 on a different number.

## 4. Find the spread of three throws

- `min` and `max` each take two numbers; the largest of three is the larger of one number and the largest of the other two.
- You need each height for both the highest and the lowest, so copy before you compare.

## 5. Find the middle throw

- The median of three is the larger of two numbers: the smaller of the first two heights, and the smaller of the third height and the larger of the first two.
