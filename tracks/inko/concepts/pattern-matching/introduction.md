# Introduction

`match` tries patterns in order and runs the body of the first that fits; it is an expression, and it must be
exhaustive:

```inko
match (line, delay) {
  case ('express', 0) -> 'express on time'
  case (_, 0) -> 'on time'
  case (name, d) if d < 60 -> '${name} delayed ${d} min'
  case _ -> 'cancelled'
}
```

Patterns are literals (`Int`, `String`, `Bool`), bindings (`name`), the wildcard `_`, tuples, enum cases such as
`Some(x)` and `None`, arrays of an exact size, and `a or b`. A guard (`if …`) adds a condition. `let` accepts a
pattern too, with `else` for one that may not match: `let Some(n) = parse(text) else return 0`.
