# About

`Bool` is a value type with two values, `true` and `false`.

## Operators

- `and` and `or` are keywords, not methods, and short-circuit: `a and b` doesn't evaluate `b` when `a` is false,
  and `a or b` doesn't evaluate `b` when `a` is true. This makes guards such as
  `count > 0 and (total / count) > 10` safe: the division never runs when `count` is zero.
- `!value` negates. Use parentheses to negate a comparison: `!(a < b)`.
- `==` and `!=` compare two booleans.

Inko's binary operators (`+`, `<` and the rest) have no precedence among themselves, but `and` and `or` are not
binary operators: each side of an `and` is evaluated as a whole, so `x > 0 and x < 10` reads as you'd expect.

## No truthiness

Conditions must be of type `Bool`. Numbers, strings, `nil` and `Option` values are never treated as true or false,
so ask the question explicitly: `count > 0`, `name.size > 0`, `value.some?`.

## Methods on Bool

```inko
true.to_int             # => 1
false.to_string         # => 'false'
true.then(fn { 'yes' }) # => Option.Some('yes')
false.then(fn { 'yes' }) # => Option.None
```

## Naming

Predicates (methods returning a `Bool`) end in `?`: `empty?`, `contains?`, `lamp_on?`. Avoid comparing a boolean
with `true` or `false` (`if done == true`); use it directly (`if done`) or negated (`if !done`).
