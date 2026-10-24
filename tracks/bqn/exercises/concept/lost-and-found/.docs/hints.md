# Hints

## General

- The [replicate documentation](https://mlochbaum.github.io/BQN/doc/replicate.html) covers `/` with masks and
  counts.
- The [indices documentation](https://mlochbaum.github.io/BQN/doc/indices.html) explains why positions count
  from `0`.

## 1. List the unclaimed items

- The flags mark the items to drop, not the ones to keep; turn them around first.

## 2. Find the items held too long

- Compare first, then ask where the `1`s are.

## 3. Expand the delivery note

- Replicate is not limited to `0` and `1`.

## 4. Read the claim ticket

- Characters compare like numbers: a digit is between `'0'` and `'9'`.
- Build a mask from two comparisons, then filter the ticket with it.

## 5. Number the shelves

- With one argument, `/` repeats each index as many times as its count.
