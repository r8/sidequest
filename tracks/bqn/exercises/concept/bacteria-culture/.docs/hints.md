# Hints

## General

- [Repeat](https://mlochbaum.github.io/BQN/doc/repeat.html) explains `⍟` with numbers, lists and negative
  counts.
- [Undo](https://mlochbaum.github.io/BQN/doc/undo.html) lists the functions BQN can invert.

## 1. Grow the culture

- Doubling is a bound function; repeat it.

## 2. Show every hour

- Give `⍟` a list of counts instead of one count.
- How many hours are there from 0 up to and including the last one?

## 3. Look back in time

- Going back an hour undoes a doubling, and a negative count repeats backwards.

## 4. Find how long it takes

- First work out how many times bigger the target is.
- The number of doublings is a logarithm, and a logarithm is an undone power.

## 5. Encode the temperature

- Combine two bound functions with `∘`, so that BQN can invert the result.

## 6. Decode the temperature

- You have a function that encodes; ask BQN for its inverse.
