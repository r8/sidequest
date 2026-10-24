# Hints

## General

- The standard library documents [Int][int] and [Float][float], including every method mentioned here.
- Operators have no precedence: parenthesise arithmetic that mixes them.

## 1. Count the full crates

- Dividing one `Int` by another drops the remainder.

## 2. Count the apples left over

- The `%` operator gives the remainder of a division.

## 3. Work out how many crates to bring

- A part-filled crate counts as a whole one. You can build on the two methods you already have, or convert to
  `Float` and round up with `ceil`.

## 4. Work out the average weight

- Integer division would drop the fraction; convert both numbers with `to_float` first.

## 5. Price a sale

- `Float` has a `round` method that takes the number of decimals to keep.

[int]: https://docs.inko-lang.org/std/latest/module/std/int/Int/
[float]: https://docs.inko-lang.org/std/latest/module/std/float/Float/
