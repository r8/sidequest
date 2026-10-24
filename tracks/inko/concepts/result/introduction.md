# Introduction

`Result[T, E]` is the result of an operation that can fail: `Result.Ok(value)` or `Result.Error(error)`.

```inko
fn pub withdraw(balance: Int, amount: Int) -> Result[Int, String] {
  if amount > balance { Result.Error('insufficient funds') } else { Result.Ok(balance - amount) }
}

match withdraw(100, 300) {
  case Ok(left) -> 'left: ${left}'
  case Error(reason) -> 'refused: ${reason}'
}
```

`ok?`, `error?`, `or`, `or_else`, `map`, `map_error` and `then` work like their `Option` counterparts, and
`Option.ok_or(error)` turns an option into a result. Don't ignore results: the compiler warns about unused ones.
