# Hints

## General

- The [arithmetic documentation](https://mlochbaum.github.io/BQN/doc/arithmetic.html) describes `⌊`, `⌈`,
  `|`, `⋆` and `√`, with one and with two arguments.
- The [expressions tutorial](https://mlochbaum.github.io/BQN/tutorial/expression.html) has more examples.

## 1. Estimate the fuel

- Work out the fuel per kilometre, or the number of hundreds of kilometres, and multiply.

## 2. Count the fuel stops

- Count the tankfuls the leg needs, rounding up, and remember the first one is already in the car.
- A leg of zero kilometres must not give a negative number of stops: the larger of two numbers helps.

## 3. Work out the arrival time

- The clock goes round every 24 hours: that is a remainder.
- Check the order of the arguments to `|`.

## 4. Buy snacks

- Divide, then round so that you never spend more than you have.

## 5. Measure as the crow flies

- `⋆` raises a number to a power, and `√` takes the square root.
- Mind the right-to-left rule when squaring the left argument.
