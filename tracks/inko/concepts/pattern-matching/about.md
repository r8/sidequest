# About

`match` expressions are compiled to decision trees, so a long `match` is as fast as hand-written branches.

## Patterns

| Pattern | Matches |
| --- | --- |
| `42`, `'abc'`, `true` | equal `Int`, `String` (also a string `Slice`) and `Bool` values |
| `CONSTANT` | the value of a constant |
| `name`, `mut name` | anything, binding it (mutably) |
| `_` | anything, binding nothing |
| `(a, b)` | a tuple, value by value |
| `Some(x)`, `Ok(v)`, `Circle(radius)` | an enum case and its values (no type prefix) |
| `{ @name = n, @age = 42 }` | a regular type, field by field; unlisted fields are wildcards |
| `[a, b]`, `[]` | an `Array` or `ByteArray` of exactly that size |
| `p1 or p2` | either pattern |

Guards (`case n if n > 0 -> …`) can use the bindings of their pattern.

## Exhaustiveness

The compiler requires every possible value to be covered, and warns about unreachable cases. `Int`, `String` and
array patterns are treated as having infinitely many values, so they need a wildcard. Enum and `Bool` matches are
exhaustive once every case is listed. Floats can't be matched (rounding makes equality unreliable), nor can traits,
`async` types, or types with a custom destructor.

## Typing

The type of a `match` is the type of its first case's body; the others must be compatible. When the bodies are
only run for their side effects, end each with `nil` (or wrap them in braces ending in `nil`).

## Ownership

Matching an owned value moves it into the `match`, and its parts move into the bindings. Matching a borrow
(`match ref value`, or a value that is already a `ref`) binds borrows instead. Bindings are dropped at the end of
their case's body.

## let patterns

```inko
let (a, b) = pair                       # irrefutable: no else
let Some(first) = list.first else return 0
let Ok(value) = parse(text) else {
  log('bad input')
  return 0
}
```

The `else` of a refutable `let` must leave the surrounding scope (`return`, `break`, `next`) or never finish
(`panic`).

## Limitations

There are no range patterns (use guards), no "rest" patterns in arrays (`[first, ..]`), and no binding of the
whole value with `@`; bind the parts you need or match on a borrow.
