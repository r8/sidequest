# Introduction

Operators are methods, and `std.ops` defines a trait for each: `Add[T, R]` for `+`, `Subtract` for `-`, `Multiply`
for `*`, `Divide`, `Modulo`, `Power` and the bitwise operators. `T` is the right-hand side's type and `R` the
result's:

```inko
import std.ops (Add)

impl Add[Distance, Distance] for Distance {
  fn pub +(other: ref Distance) -> Distance {
    Distance(metres: @metres + other.metres)
  }
}
```

The signature must match the trait's, argument name included; for a value-type argument the `ref` is dropped
(`fn pub *(other: Int)`). Operators keep Inko's rule of no precedence.
