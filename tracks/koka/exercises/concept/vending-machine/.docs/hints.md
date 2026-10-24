# Hints

## General

- The Koka book shows [exceptions as an effect](https://koka-lang.github.io/koka/doc/book.html#sec-handlers) and
  the [exn module](https://koka-lang.github.io/koka/doc/std_core_exn.html) lists `throw`, `try` and `untry`.

## 1. Sell an item

- `throw` takes the message.

## 2. Try to sell an item

- `try` turns the exception into an `error`, and an `error` converts to a `maybe`.

## 3. Sell or refund

- Either `try` with a handler function, or `try` and `.default`.

## 4. Show the outcome

- Match on the result of `try`: `Ok` and `Error`.
- Remember the parentheses around the block in `match try({ … })`.

## 5. Sell several items

- `foldl` carries the coins from one item to the next.
- No `try` is needed: an exception from `vend` already ends the whole function.
