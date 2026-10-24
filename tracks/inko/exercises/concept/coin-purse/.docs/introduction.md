# Introduction

In Inko, operators are methods. `a + b` calls the method `+` on `a` with `b` as its argument, and `a == b` calls
`==`. Your own types get operators by implementing the traits that define them.

## Arithmetic operators

The arithmetic operators are defined by traits in `std.ops`:

| Operator | Trait |
| --- | --- |
| `+` | `Add[T, R]` |
| `-` | `Subtract[T, R]` |
| `*` | `Multiply[T, R]` |
| `/` | `Divide[T, R]` |
| `%` | `Modulo[T, R]` |
| `**` | `Power[T, R]` |

Each trait has two type parameters: `T`, the type of the right-hand side, and `R`, the type of the result. For a
`Distance` type that can be added to another `Distance`:

```inko
import std.ops (Add)

type pub Distance {
  let @metres: Int
}

impl Add[Distance, Distance] for Distance {
  fn pub +(other: ref Distance) -> Distance {
    Distance(metres: @metres + other.metres)
  }
}

let total = Distance(metres: 300) + Distance(metres: 450) # a Distance of 750 metres
```

The method's signature must match the trait's exactly, including the argument's name, `other`. The trait borrows
the right-hand side (`ref Distance`), so `+` can't take ownership of it. For a value type such as `Int`, a borrow
is the same as a copy, and the argument is written as plain `Int`:

```inko
impl Multiply[Int, Distance] for Distance {
  fn pub *(other: Int) -> Distance {
    Distance(metres: @metres * other)
  }
}

Distance(metres: 300) * 2 # a Distance of 600 metres
```

The right-hand side doesn't have to be the same type as the left: here a `Distance` is multiplied by an `Int`. The
other way around, `2 * distance`, would need `Int` to implement `Multiply[Distance, Distance]`, which it doesn't.

Operator methods are still methods: they have no precedence over one another, so `a + b * c` is still
`(a + b) * c`.

## Equality

`==` comes from the `Equal` trait in `std.cmp`. It has one required method, `==`, and a default `!=`:

```inko
import std.cmp (Equal)

impl Equal for Distance {
  fn pub ==(other: ref Distance) -> Bool {
    @metres == other.metres
  }
}

Distance(metres: 5) == Distance(metres: 5) # => true
Distance(metres: 5) != Distance(metres: 7) # => true
```

Without an `Equal` implementation, comparing two values of your type is a compile-time error. You decide what
equality means: two values can be equal even if their fields differ, as long as they mean the same thing.

## Ordering

`Compare` (also from `std.cmp`) has one required method, `cmp`, which returns an `Ordering`: `Ordering.Less`,
`Ordering.Equal` or `Ordering.Greater`. It provides `<`, `<=`, `>` and `>=` as default methods, and is what
`Array.sort` uses:

```inko
import std.cmp (Compare, Ordering)

impl Compare for Distance {
  fn pub cmp(other: ref Distance) -> Ordering {
    @metres.cmp(other.metres)
  }
}

Distance(metres: 5) < Distance(metres: 7) # => true

let distances = [Distance(metres: 7), Distance(metres: 5)]

distances.sort # now ordered from shortest to longest
```

`Int`, `Float` and `String` implement `Compare` themselves, so comparing a field is often all `cmp` needs. Keep
`Equal` and `Compare` consistent: two values that are `==` should compare as `Ordering.Equal`.

## Formatting for tests

The tests compare values with `t.equal`, which needs `Equal` to compare them and `Format` (from `std.fmt`) to show
them when they differ. `Format` has one method, `fmt`, which writes a debugging representation to a `Formatter`:

```inko
import std.fmt (Format, Formatter)

impl Format for Distance {
  fn pub fmt(formatter: mut Formatter) {
    formatter.tuple('Distance').field(@metres).finish
  }
}
```

`Format` is for programmers; `ToString`, from the previous lesson, is for showing values to people.

## Fields of other values

Methods of a type can read the private fields of _other_ values of the same type, as `other.metres` does above,
because a private field is private to the code around the type (its module), not to each value.
