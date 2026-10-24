# About

## Equal

```inko
trait pub Equal {
  fn pub ==(other: ref Self) -> Bool
  fn pub !=(other: ref Self) -> Bool { !(self == other) }
}
```

Equality is _semantic_: you decide when two values are the same. It should be reflexive, symmetric and transitive,
or collections such as `Map` and methods such as `contains?` behave oddly. Types without an `Equal` implementation
can't be compared with `==` at all, and that includes enums: implement it with a `match` on `(self, other)`.

Generic types implement it conditionally: `Array[T]`, `Option[T]`, `Map[K, V]` and tuples are `Equal` exactly when
their contents are.

## Compare and Ordering

```inko
trait pub Compare {
  fn pub cmp(other: ref Self) -> Ordering
  # <, <=, > and >= are default methods built on cmp
}
```

`Ordering` is a `copy` enum with the cases `Less`, `Equal` and `Greater`, and implements `Equal` and `Format`
itself, so it can be matched or compared. `Int`, `Float`, `String` and `Bool` implement `Compare`, so a type
usually compares one of its fields. To compare by several fields, compare the first and only fall back to the next
when the result is `Equal`:

```inko
fn pub cmp(other: ref Version) -> Ordering {
  match @major.cmp(other.major) {
    case Equal -> @minor.cmp(other.minor)
    case ordering -> ordering
  }
}
```

Keep `Equal` and `Compare` in agreement: `a == b` should hold exactly when `a.cmp(b)` is `Equal`.

`Array.sort` needs `Compare`; `sort_by(fn (a, b) { … })` sorts by any ordering without implementing the trait.
`std.cmp.min(a, b)` and `max(a, b)` work on any `Compare` type.

## Hash

To use a type as a `Map` key it must implement `Equal` and `std.hash.Hash`. A `hash` method feeds the same fields
that `==` compares into the hasher:

```inko
impl Hash for Point {
  fn pub hash[H: mut + Hasher](hasher: mut H) {
    @x.hash(hasher)
    @y.hash(hasher)
  }
}
```

## Format

`std.fmt.Format` (`fn pub fmt(formatter: mut Formatter)`) produces a debugging representation; `std.test` uses it
to print the values of a failed `equal`. `Formatter` has helpers: `tuple('Name').field(x).finish`,
`object('Name').field('x', x).finish`, `array`, and `write(string)` for anything else.
