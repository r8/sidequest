# Hints

## General

- The [numbers and arithmetic](https://janet-lang.org/docs/numbers.html) page of the Janet documentation covers how numbers work.
- The [math module](https://janet-lang.org/api/math.html) lists the rounding functions.

## 1. Count the full crates

- `/` can return a fraction; there is a function for division that rounds down.
- Giving the crate size a name with `def` keeps the 24 in one place.

## 2. Count the loose apples

- The loose apples are the remainder of the division.

## 3. Count the crates to bring

- Divide exactly, then round up.

## 4. Calculate the average weight

- Exact division is what you want here.

## 5. Round prices to the cent

- The rounding functions round to whole numbers. Scale the amount so that cents become whole numbers first, then scale back.
