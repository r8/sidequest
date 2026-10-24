# Introduction

`std.cmp.Equal` gives a type `==` (required) and `!=` (default); `std.cmp.Compare` gives it `cmp` (required),
returning `Ordering.Less`, `Ordering.Equal` or `Ordering.Greater`, plus `<`, `<=`, `>` and `>=`. `Array.sort` and
`std.cmp.min`/`max` rely on `Compare`.

```inko
impl Equal for Distance {
  fn pub ==(other: ref Distance) -> Bool {
    @metres == other.metres
  }
}

impl Compare for Distance {
  fn pub cmp(other: ref Distance) -> Ordering {
    @metres.cmp(other.metres)
  }
}
```

`std.test`'s `equal` needs `Equal` and `Format` (`std.fmt`) for the values it compares.
