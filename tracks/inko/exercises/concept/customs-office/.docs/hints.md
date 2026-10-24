# Hints

## General

- The [Result][result] documentation lists every method with an example.

## 1. Check a weight

- Return `Result.Error(…)` or `Result.Ok(…)` from each branch.

## 2. Read a number

- `Int.parse` returns an `Option`; `ok_or` turns it into a `Result`.

## 3. Read a weight

- `then` passes the number from a successful read on to `check_weight`.

## 4. Add the duty

- `map` changes the value inside an `Ok`. Mind the left-to-right order of operators.

## 5. Name the form

- `map_error` changes only the error.

## 6. Stamp the parcel

- `match` on the `Ok` and `Error` cases.

[result]: https://docs.inko-lang.org/std/latest/module/std/result/Result/
