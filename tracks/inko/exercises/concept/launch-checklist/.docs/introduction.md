# Introduction

The previous lesson's methods returned `Result.Error(…)` and `Result.Ok(…)` by hand, and chained steps with
`then`. That works, but a method with several steps that can each fail gets nested quickly. Inko has two keywords
that make error handling read like straight-line code: `throw` and `try`.

## Error types

First, a better kind of error. A string tells a person what went wrong, but code can't easily tell one string
from another. An enum with a case per failure can be matched, and each case can carry the details:

```inko
type pub enum OrderError {
  case OutOfStock(String)
  case TooMany(Int)
  case Closed
}
```

A method that can fail this way returns `Result[T, OrderError]`, and its callers can `match` on exactly what went
wrong.

## throw

`throw value` returns `Result.Error(value)` from the current method. It can only be used in a method whose return
type is a `Result`:

```inko
fn pub check_quantity(quantity: Int) -> Result[Int, OrderError] {
  if quantity > 10 { throw OrderError.TooMany(quantity) }

  Result.Ok(quantity)
}
```

This is exactly `return Result.Error(OrderError.TooMany(quantity))`, but says what it means. Because `throw`
leaves the method, it can be used anywhere a value is expected, such as a `match` case or the `else` of a `let`:

```inko
let Some(price) = prices.get(item).ok else throw OrderError.OutOfStock(item)
```

## try

`try expression` takes a `Result`. For an `Ok`, it produces the value inside. For an `Error`, it returns that error
from the current method immediately:

```inko
fn pub order(item: String, quantity: Int, open: Bool) -> Result[Int, OrderError] {
  if !open { throw OrderError.Closed }

  let checked = try check_quantity(quantity)
  let price = try price_of(item)

  Result.Ok(price * checked)
}
```

Each `try` is a checkpoint: if `check_quantity` fails, `order` returns its error and `price_of` never runs. Without
`try`, the same method would need a `match` (or a `then`) for every step.

`try` can be used inside any expression, including as an argument: `try check_quantity(try parse(text))`. When you
only need the check and not its value, `try` on its own line is enough. The error types must match: `try` on a
`Result[Int, OrderError]` only works in a method that returns a `Result[…, OrderError]`. When they don't, convert
the error first with `map_error`:

```inko
let quantity = try Int.parse(text, 10).ok_or(OrderError.TooMany(0))
```

`try` works on `Option` values too, in methods that return an `Option`: a `None` is returned as is.

## Results without a value

Some checks have nothing to return when they succeed. Their success type is `Nil`, and they finish with
`Result.Ok(nil)`:

```inko
fn pub open_shop(staff: Int) -> Result[Nil, OrderError] {
  if staff == 0 { throw OrderError.Closed }

  Result.Ok(nil)
}
```

## Errors versus panics

A `Result` is for failures the caller should handle: bad input, a missing file, a closed shop. A _panic_ is for
bugs, situations that should never happen if the program is correct. `panic('message')` stops the program at once,
printing the message and where it happened, and can't be caught:

```inko
fn pub average(values: ref Array[Int]) -> Int {
  if values.empty? { panic('average() needs at least one value') }

  Int.sum(values.iter) / values.size
}
```

`or_panic` (and `get`) unwrap a result or an option and panic on an error. Use them when an error really is a bug,
such as reading an index you just checked; everywhere else, return a `Result`.

## Methods on error enums

Error enums are ordinary enums, so they can have methods. A method that turns each case into a message is a common
one:

```inko
type pub enum OrderError {
  …

  fn pub message -> String {
    match self {
      case OutOfStock(item) -> '${item} is sold out'
      case TooMany(n) -> "can't order ${n} at once"
      case Closed -> 'the shop is closed'
    }
  }
}
```
