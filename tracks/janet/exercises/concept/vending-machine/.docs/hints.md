# Hints

## General

- [Error handling](https://janet-lang.org/docs/fibers/error_handling.html) in the Janet documentation covers `error`, `try` and `protect`.
- The [core API](https://janet-lang.org/api/index.html) documents `error`, `errorf` and `assert`.

## 1. Dispense a snack

- Look the slot up first; a missing slot is `nil`.
- `string` or `errorf` builds the message from its parts.
- The slot is a table, so `put` can lower its stock.

## 2. Dispense without complaining

- `try` takes the expression and a handler `([err] …)`.

## 3. Check the coins

- `assert` raises an error with your message when its condition is false.
- `index-of` tells you whether a value is in a tuple, or you can compare with `or`.

## 4. Tell the attendant about sold-out slots only

- The error value is a string; `string/has-prefix?` tells you which kind it is.
- `(error err)` in the handler raises the same error again.

## 5. Log every attempt

- `protect` returns a tuple of whether the body succeeded and its result or error.
- You can destructure that tuple.
