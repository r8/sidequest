# Hints

## General

- [Depth](https://mlochbaum.github.io/BQN/doc/depth.html) covers nesting and `≡`.
- [Enclose](https://mlochbaum.github.io/BQN/doc/enclose.html), [pair](https://mlochbaum.github.io/BQN/doc/pair.html)
  and [join](https://mlochbaum.github.io/BQN/doc/join.html) cover `<`, `⋈` and `∾`.
- [Match](https://mlochbaum.github.io/BQN/doc/match.html) compares whole values.

## 1. Count the layers

- One primitive measures how deeply a value is nested.

## 2. Empty boxes into one

- Joining the elements of a list removes one level of nesting.

## 3. Put something in a box

- Joining a box onto a box adds its items one by one; make the new thing a single value first.

## 4. Label a box

- There is a function that makes a two-element list of its arguments.

## 5. Stack the boxes on a shelf

- Merge turns a list of equal-length lists into a table.

## 6. Find the identical boxes

- Match the right argument with each box of the list; it has to be one value to be paired with every box.
