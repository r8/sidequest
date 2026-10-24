# Introduction

`Option[T]` represents a value that may be missing: `Option.Some(value)` or `Option.None`. Inko has no null, so
methods that may have nothing to return, such as `pop`, `first`, `find` and `Int.parse`, return an option.

```inko
fn pub half(number: Int) -> Option[Int] {
  if number % 2 == 0 { Option.Some(number / 2) } else { Option.None }
}

half(10).map(fn (n) { n * 3 }).or(0) # => 15
half(7).or(0)                         # => 0
```

`some?` and `none?` ask; `or`, `or_else`, `get` and `or_panic` unwrap; `map` and `then` transform. All but the
questions consume the option.
