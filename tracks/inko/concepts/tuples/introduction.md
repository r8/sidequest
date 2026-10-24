# Introduction

A tuple is a fixed-size group of values of possibly different types, written `(3, 4)` or `('Vega', 0.03)`. Its type
is written the same way: `(Int, Int)`, `(String, Float)`. Values are read by position with `.0`, `.1` and so on,
and a tuple can't be changed once created.

Methods return several values as a tuple, and `let` takes one apart:

```inko
fn pub divide(number: Int, by: Int) -> (Int, Int) {
  (number / by, number % by)
}

let (quotient, remainder) = divide(17, by: 5)
```

Patterns nest (`let (name, (x, y)) = star`), and `_` ignores a value.
