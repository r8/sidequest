# Introduction

An `Option` says that a value may be missing, but not _why_. When an operation can fail and the caller needs to know
what went wrong, Inko returns a `Result`: either `Result.Ok(value)` for success, or `Result.Error(error)` for
failure. The type names both: `Result[Int, String]` is "an `Int`, or a `String` describing an error".

```inko
fn pub withdraw(balance: Int, amount: Int) -> Result[Int, String] {
  if amount > balance {
    Result.Error('insufficient funds')
  } else {
    Result.Ok(balance - amount)
  }
}

withdraw(100, 30) # => Result.Ok(70)
withdraw(100, 300) # => Result.Error('insufficient funds')
```

The error can be any type. Strings are fine for messages meant for people; the next lesson uses enums for errors
that code needs to tell apart.

`Array.get` and `Map.get`, which you've used with `or`, return results: their error says which index or key was
missing.

## Matching

`match` handles both outcomes, with the cases `Ok(…)` and `Error(…)`:

```inko
match withdraw(100, 300) {
  case Ok(left) -> 'you have ${left} left'
  case Error(reason) -> 'refused: ${reason}'
}
```

## Asking and unwrapping

Results have many of the same methods as options:

```inko
withdraw(100, 30).ok?            # => true
withdraw(100, 300).error?        # => true
withdraw(100, 300).or(0)         # => 0
withdraw(100, 300).or_else(fn (error) { error.size }) # => 18
```

`or_else` passes the error to its closure, so the default can depend on it. `get` and `or_panic` unwrap an `Ok` and
panic on an `Error`, for cases where an error is a bug. `ok` and `error` turn a result into an `Option` of one side.

Going the other way, `Option.ok_or(error)` turns an option into a result, with the given error for a `None`:

```inko
Int.parse('12', 10).ok_or('not a number') # => Result.Ok(12)
Int.parse('xx', 10).ok_or('not a number') # => Result.Error('not a number')
```

## Transforming

`map` changes the value inside an `Ok`; an `Error` passes through unchanged. `map_error` does the opposite: it
changes the error and leaves an `Ok` alone.

```inko
withdraw(100, 30).map(fn (left) { left * 2 })          # => Result.Ok(140)
withdraw(100, 300).map_error(fn (e) { 'ATM: ${e}' })   # => Result.Error('ATM: insufficient funds')
```

`then` chains a second step that can fail too. Its closure receives the `Ok` value and returns a new result; an
`Error` from the first step skips the closure:

```inko
withdraw(100, 30).then(fn (left) { withdraw(left, 50) })  # => Result.Ok(20)
withdraw(100, 30).then(fn (left) { withdraw(left, 500) }) # => Result.Error('insufficient funds')
```

Chaining keeps the "check, then continue" logic in one expression, and the first error stops the chain.

## Results are used up

Like options, results are consumed by `or`, `map`, `then` and friends, so unwrap one once and keep the value in a
variable. `ok?` and `error?` only look.

## Don't ignore results

The compiler warns when the result of an expression is unused. For a `Result` that matters: ignoring it means
ignoring an error. Handle it, or assign it to `_` (`let _ = save(file)`) to say you ignore it on purpose.
