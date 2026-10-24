# Hints

## General

- [The Koka book on `with` statements](https://koka-lang.github.io/koka/doc/book.html#sec-with) shows how a
  `with` translates to a call with a trailing lambda.
- `with` captures every statement below it in its block, so keep the result of a function outside the block that
  the `with` is in.

## 1. Soak twice

- The action is a function without parameters: call it like any other function, twice.

## 2. Visit every bed that is switched on

- `foreach` visits a list in order; the action should only run for some of the beds.
- `starts-with` gives back a maybe; `.is-just` turns it into a `bool`.

## 3. Plan the rounds

- Collect the entries in a local `var`, adding to the front, and reverse the list at the end.
- `for` counts the rounds, and `each-bed` from task 2 visits the beds of one round.
- `with bed <- each-bed(garden)` inside the round's lambda keeps the code flat.

## 4. Plan a double soak

- Combine `each-bed` from task 2 with `twice` from task 1, the same way as in task 3.
