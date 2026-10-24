# Introduction

Errors in Inko are values: a method that can fail returns a `Result`, often with an enum of failure cases as its
error type. Two keywords keep such code flat:

- `throw error` returns `Result.Error(error)` from the method;
- `try expression` unwraps an `Ok`, or returns the `Error` from the method at once (and does the same for `None`
  in a method returning an `Option`).

```inko
fn pub order(text: String) -> Result[Int, OrderError] {
  let quantity = try parse_quantity(text)

  if quantity > 10 { throw OrderError.TooMany(quantity) }

  Result.Ok(quantity)
}
```

Panics (`panic`, `or_panic`) are for bugs and stop the program; they can't be caught.
