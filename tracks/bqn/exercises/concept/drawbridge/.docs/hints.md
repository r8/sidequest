# Hints

## General

- The [arithmetic documentation](https://mlochbaum.github.io/BQN/doc/arithmetic.html) lists the comparison
  functions.
- The [logic documentation](https://mlochbaum.github.io/BQN/doc/logic.html) explains `∧`, `∨` and `¬`.

## 1. Check whether a boat fits under the bridge

- A single comparison is the whole answer.

## 2. Check for rush hour

- Write the check for one period first: two comparisons joined with `∧`.
- Parenthesise every condition except the rightmost one.

## 3. Decide whether to raise the bridge

- Use the functions from the first two tasks, and `¬`.

## 4. Charge the toll

- A boolean can multiply an amount: `5 × 0` is `0`.
- Work out the toll for a visitor first, then make it zero for a resident.

## 5. Spot a blown bulb

- Compare the two lamps.
