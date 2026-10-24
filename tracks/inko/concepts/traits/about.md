# About

## Definitions

```inko
trait pub Shape {
  fn pub area -> Float                 # required
  fn pub mut scale(factor: Float)      # required, mutating
  fn pub describe -> String {          # default
    'a shape of area ${area}'
  }
}
```

Required methods have no body. Default methods may call any method of the trait (and of its required traits).
Inside a default method, `self` has the type `Self`, the implementing type, which can't be cast to other types and
can only be captured by `fn move` closures when it is owned.

## Implementations

`impl Shape for Circle { … }` must define every required method with a compatible signature, and may override
defaults. A type can implement a trait only once, and two traits with a method of the same name can't both be
implemented by one type.

Implementations can be conditional on type parameters: `impl Equal for Box if T: Equal { … }` exists only for
boxes whose contents are comparable.

## Trait values and dispatch

`value as Shape` turns an owned value into a trait value; arrays and fields typed with a trait hold such values,
and calls on them are dispatched at runtime. Only regular heap types can be cast: `inline` and `copy` types can't,
and a trait whose methods use `Self` in their signature (such as `Clone`) can't be used as a value type. A method
that should accept any implementing type without casting is better written as a generic method, `fn draw[T: Shape]
(shape: ref T)`, which is resolved at compile time (see the generics lesson).

## Required traits

`trait pub Pet: Animal + ToString { … }` requires implementors to implement `Animal` and `ToString` too.

## Common standard traits

| Trait | Module | Provides |
| --- | --- | --- |
| `ToString` | `std.string` | `to_string`, used by interpolation |
| `Equal` | `std.cmp` | `==`, `!=` (default) |
| `Compare` | `std.cmp` | `cmp` and the defaults `<`, `<=`, `>`, `>=`; used by `sort` |
| `Hash` | `std.hash` | hashing, for `Map` keys |
| `Format` | `std.fmt` | debug formatting, used by `std.test` |
| `Clone` | `std.clone` | `clone` |
| `Drop` | `std.drop` | a destructor |
| `Iter` | `std.iter` | iteration |
| `Add`, `Subtract`, … | `std.ops` | operators |

## Reopening and orphan implementations

A type can implement a trait in any module of the program, not just where the type or the trait is defined, as
long as both are visible there.
