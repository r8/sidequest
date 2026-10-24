# Hints

## General

- The manual's [methods and closures][closures] page explains closures, captures and `fn move`.

## 1. Apply a rule to the price list

- Loop over the prices, `call` the rule on each one, and push the result into a new array.

## 2. Count the prices that match

- The test returns a `Bool` you can use directly as an `if` condition.

## 3. Make a discount rule

- Return a closure. Its argument needs a type, because nothing passes it straight to a method.
- The closure can use `percent`: it captures it.

## 4. Make a price tag printer

- `/ 100` gives the whole units and `% 100` the cents. `pad_start` gives the cents two digits.

## 5. Combine two rules

- The returned closure calls both rules, so it must own them: make it an `fn move` closure.

[closures]: https://docs.inko-lang.org/manual/latest/getting-started/methods/
