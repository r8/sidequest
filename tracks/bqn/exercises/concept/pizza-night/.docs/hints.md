# Hints

## General

- The [expressions tutorial](https://mlochbaum.github.io/BQN/tutorial/expression.html) covers arithmetic and
  the right-to-left rule.
- The [blocks documentation](https://mlochbaum.github.io/BQN/doc/block.html) explains `𝕩` and `𝕨`.

## 1. Work out how long the dough still has to rise

- Subtract the minutes so far from the full rising time.

## 2. Work out the baking time

- Expressions are read from right to left: write the part that must happen first on the right.

## 3. Work out how much dough to make

- Count the spare ball as one more pizza.
- Parentheses are not always needed: think about what `250 ×` takes as its argument.

## 4. Work out when dinner is ready

- You have already written functions for both parts of the wait; call them.
- In a block called with two arguments, `𝕨` is the left one and `𝕩` the right one.

## 5. Share the slices

- Count all the slices first, then divide by the guests.
