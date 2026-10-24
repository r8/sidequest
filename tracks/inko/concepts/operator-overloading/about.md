# About

## The traits

| Operator | Trait in `std.ops` | Method |
| --- | --- | --- |
| `+` | `Add[T, R]` | `fn pub +(other: ref T) -> R` |
| `-` | `Subtract[T, R]` | `fn pub -(other: ref T) -> R` |
| `*` | `Multiply[T, R]` | `fn pub *(other: ref T) -> R` |
| `/` | `Divide[T, R]` | `fn pub /(other: ref T) -> R` |
| `%` | `Modulo[T, R]` | `fn pub %(other: ref T) -> R` |
| `**` | `Power[T, R]` | `fn pub **(other: ref T) -> R` |
| `&`, `\|`, `^` | `BitAnd`, `BitOr`, `BitXor` | |
| `<<`, `>>`, `>>>` | `ShiftLeft`, `ShiftRight`, `UnsignedShiftRight` | |

Comparison operators come from `std.cmp`: `==` and `!=` from `Equal`, `<`, `<=`, `>`, `>=` from `Compare`.

## Rules

- A type can implement the same operator trait several times with different type arguments, for example
  `Multiply[Int, Vector]` and `Multiply[Vector, Int]`.
- The left-hand side is always the receiver: `2 * vector` uses `Int`'s `*`, so it only works if `Int` implements
  the trait for your type, which it doesn't. Put your type on the left.
- Argument names are part of a method's signature (because of named arguments), so an implementation must call the
  argument `other`.
- When `T` is a value type, `ref T` is the same as `T`, and the implementation writes `other: Int`.
- Compound assignment works with any `+`: `total += amount` is `total = total + amount`, given a `let mut total`.

## Unary operators

Inko has no unary minus operator: `-5` is a negative literal, and `-x` on a variable is a syntax error (`Int` and
`Float` offer `x.opposite` instead). `!` only works on `Bool`. Give your own types a method such as `opposite` when
they need negation.

## Precedence

All binary operators have equal precedence and are evaluated from left to right, whether built in or overloaded.
`a + b * c` is `(a + b) * c`.

## When not to overload

Operators should mean what readers expect: `+` for combining amounts or vectors makes code shorter, while `+` for
"add a user to a group" hides what happens. A named method is usually the better choice when there's doubt.
