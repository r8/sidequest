# Hints

## General

- [Exception handling](https://gforth.org/manual/Exception-Handling.html) in the Gforth manual describes `catch` and `throw`.
- The [exceptions tutorial](https://gforth.org/manual/Exceptions-Tutorial.html) has short examples.

## 1. Give change

- Compare before subtracting, keeping both numbers with a shuffle.

## 2. Take an item from a slot

- An empty slot holds 0.

## 3. Check the slot number

- One comparison word checks a range for you; remember its upper limit is excluded.

## 4. Refund when the money is short

- `catch` needs the execution token of `change`.
- After a throw, the two items below the code are not the price and the amount paid any more; keep a copy of the amount paid where `change` cannot reach it.
- An unexpected code has to go on up with `throw`.

## 5. Return the credit after a fault

- `catch` already leaves 0 or the code; you only need to act when it is not 0.
