# About

`Option[T]` is an enum in `std.option`, available everywhere without an import:

```inko
type pub inline enum Option[T] {
  case Some(T)
  case None
}
```

## Methods

| Method | Result for `Some(v)` | Result for `None` |
| --- | --- | --- |
| `some?`, `none?` | `true`, `false` | `false`, `true` |
| `or(default)` | `v` | `default` |
| `or_else(fn)` | `v` | the closure's result |
| `get`, `or_panic_with(message)` | `v` | panics |
| `map(fn (T) -> R)` | `Some(fn(v))` | `None` |
| `then(fn (T) -> Option[R])` | `fn(v)` | `None` |
| `else(fn -> Option[T])` | `Some(v)` | the closure's result |
| `zip(other)` | `Some((v, w))` if `other` is `Some(w)` | `None` |
| `ok_or(error)` | `Result.Ok(v)` | `Result.Error(error)` |
| `as_ref`, `as_mut` | `Some(ref v)`, `Some(mut v)` | `None` |

Everything except `some?`, `none?`, `as_ref` and `as_mut` takes ownership of the option (it is an `fn move`
method). To inspect an option you want to keep, borrow its value with `as_ref` first:
`maybe.as_ref.map(fn (v) { v.size })`.

## Pattern matching

`match` is the most flexible way to use an option, and `let … else` unwraps one or leaves the method:

```inko
match find_user(id) {
  case Some(user) -> greet(user)
  case None -> 'nobody'
}

let Some(user) = find_user(id) else return 'nobody'
```

## `try`

In a method that itself returns an `Option`, `try expression` unwraps a `Some` or returns `None` from the method
immediately:

```inko
fn pub total_size(first: String, second: String) -> Option[Int] {
  let a = try Int.parse(first, 10)
  let b = try Int.parse(second, 10)

  Option.Some(a + b)
}
```

The error-handling lesson covers `try` in depth.

## Option or Result?

Use `Option` when "missing" needs no explanation, such as looking something up. When the caller needs to know why
something failed, return a `Result`.
