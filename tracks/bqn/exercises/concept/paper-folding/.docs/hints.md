# Hints

## General

- The [blocks documentation](https://mlochbaum.github.io/BQN/doc/block.html) describes `𝕊` and headers.
- The [functional programming documentation](https://mlochbaum.github.io/BQN/doc/functional.html) discusses
  recursion in BQN.

## 1. Measure a folded sheet

- With no folds the sheet is 0.1 millimetres thick: that is the base case.
- One more fold doubles the thickness of one fold fewer.

## 2. Count the folds to reach a height

- Carry the number of folds so far in an accumulator on the left, starting from 0.
- Your `Thickness` function tells you whether enough folds have been made.

## 3. Find the largest square tile

- The description is already a recursive definition: a header `𝕊 a‿0:` can be the base case.

## 4. Count the squares for origami

- The squares from this cut plus the squares from what is left.
- A strip of zero width has no squares in it.

## 5. Name the paper sizes

- Size 0 is the base case.
- Destructure the result of the recursive call into names, then build the new pair from them.
