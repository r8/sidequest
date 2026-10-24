# Hints

## General

- [The Koka book on return operations](https://koka-lang.github.io/koka/doc/book.html#sec-return) and
  [a state effect](https://koka-lang.github.io/koka/doc/book.html#sec-state) show handlers with state and
  `return` clauses.
- [Local mutable variables](https://koka-lang.github.io/koka/doc/book.html#sec-var) explains `var`.

## 1. Number the volunteers

- Keep the next number in a `var` declared before the handler.
- The clause has to return the current number and move the variable on.

## 2. Count the sightings

- A `return(x)` clause pairs the action's result with the count.

## 3. Keep the log

- Add each bird to the front of a list, and reverse it once at the end.

## 4. Count the species

- Only add a bird to the list when it is not in it yet: `contains` tells you.
- The `return` clause does not have to use the action's result.
