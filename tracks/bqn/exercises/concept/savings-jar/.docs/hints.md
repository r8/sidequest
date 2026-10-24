# Hints

## General

- The [scan documentation](https://mlochbaum.github.io/BQN/doc/scan.html) covers `` ` ``, its order and initial
  values.
- The [fold documentation](https://mlochbaum.github.io/BQN/doc/fold.html) explains the identities scan shares.

## 1. Follow the balance

- A running total is a scan with `+`.

## 2. Start from the birthday money

- A scan takes its starting value as a left argument.

## 3. Keep a record

- Dyadic `⌈` keeps the larger of two numbers; scan it.

## 4. Stay out of debt

- Compare every balance with zero first.
- Which boolean scan stays `1` only while everything so far was `1`?

## 5. Reach the goal

- Compute the balances first, then compare them with the price.
- Which boolean scan becomes `1` and stays `1`?
