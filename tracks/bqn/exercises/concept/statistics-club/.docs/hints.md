# Hints

## General

- [Trains](https://mlochbaum.github.io/BQN/doc/train.html) explains 2-trains and 3-trains.
- [Tacit programming](https://mlochbaum.github.io/BQN/doc/tacit.html) shows how trains and combinators
  work together.
- [Identity functions](https://mlochbaum.github.io/BQN/doc/identity.html) describes `⊢` and `⊣`.

## 1. Find the mean

- A 3-train combines the results of its outer functions with its middle one.

## 2. Find the range

- Both outer functions are folds.

## 3. Find how far each value is from the mean

- `⊢` in a train stands for the argument.
- You may use `Mean` inside the train.

## 4. Find the variance

- A 2-train applies one function to the result of another.
- Square the deviations with a modified function, then take the mean.

## 5. Count the values above a mark

- Called with two arguments, a 2-train passes both to its right function.

## 6. Find a weighted mean

- In a train called with two arguments, `⊣` is the left argument.
- `+´∘×` is a single train part.
