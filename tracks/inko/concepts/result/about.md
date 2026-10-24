# About

`Result[T, E]` is an inline enum in `std.result`, available without an import:

```inko
type pub inline enum Result[T, E] {
  case Ok(T)
  case Error(E)
}
```

## Methods

| Method | `Ok(v)` | `Error(e)` |
| --- | --- | --- |
| `ok?`, `error?` | `true`, `false` | `false`, `true` |
| `ok`, `error` | `Some(v)`, `None` | `None`, `Some(e)` |
| `or(default)` | `v` | `default` |
| `or_else(fn (E) -> T)` | `v` | the closure's result |
| `get`, `or_panic_with(message)` | `v` | panics |
| `or_panic` (when `E: ToString`) | `v` | panics with the error's text |
| `map(fn (T) -> R)` | `Ok(fn(v))` | `Error(e)` |
| `map_error(fn (E) -> R)` | `Ok(v)` | `Error(fn(e))` |
| `then(fn (T) -> Result[R, E])` | `fn(v)` | `Error(e)` |
| `else(fn (E) -> Result[T, R])` | `Ok(v)` | `fn(e)` |

All except `ok?` and `error?` consume the result.

`Result.collect(iterator)` turns an iterator of results into `Ok(array)` of all the values, or the first `Error`.

## Errors as values

Inko has no exceptions: an error is an ordinary value returned from a method. Its type is part of the signature,
so callers see which methods can fail and how. Common error types:

- `String`, for messages meant for people;
- an enum of the ways something fails (`case NotFound`, `case InvalidInput(String)`), for errors code must tell
  apart;
- library error types such as `std.io.Error`, `std.array.OutOfBounds` and `std.map.MissingKey`.

## Panics are different

A panic (`panic('message')`, `or_panic`, an out-of-bounds `set`, integer overflow) stops the whole program; it can't
be caught. Panics are for bugs, where continuing makes no sense. Anything a caller could reasonably recover from
should be a `Result`.

## throw and try

The next lesson's `throw` and `try` keywords make returning and propagating errors short:
`throw error` is `return Result.Error(error)`, and `try expr` unwraps an `Ok` or returns the `Error` from the
method.
