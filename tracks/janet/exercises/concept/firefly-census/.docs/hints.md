# Hints

## General

- The Janet documentation's [flow control](https://janet-lang.org/docs/flow.html) page covers `while`, `for` and `each`.
- [Bindings](https://janet-lang.org/docs/bindings.html) describes `var` and `set`.

## 1. Count all the fireflies

- Keep a running total in a `var` and add to it for each night.
- Return the variable after the loop: the loop itself returns `nil`.

## 2. Count the busy nights

- This is the same shape as the first task, with a condition inside the loop.

## 3. Find the first quiet night

- You need the index, not the count, so loop over the positions.
- `break` stops the loop once you have found the night.

## 4. Correct the counts

- `put` replaces the element at an index.
- A `while` loop can move its index on by 7 at a time.

## 5. Find when the goal was reached

- Keep two variables: the total so far and the number of nights counted.
- Stop as soon as the total reaches the goal, and decide afterwards what to return.
