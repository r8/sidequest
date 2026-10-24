# Hints

## General

- The Janet documentation's [syntax and the parser](https://janet-lang.org/docs/syntax.html) page describes how expressions are written.
- [Bindings](https://janet-lang.org/docs/bindings.html) covers `def`, and [functions](https://janet-lang.org/docs/functions.html) covers `defn`.

## 1. Define the proofing time

- A constant is a name bound with `def`.

## 2. Calculate the remaining proofing time

- Subtract with `-`, putting the function first: `(- a b)`.
- You can use the constant from the first task.

## 3. Calculate the preparation time

- Multiply the number of rounds by the minutes one round takes.

## 4. Calculate the total working time

- A function can call another function you have already defined.
