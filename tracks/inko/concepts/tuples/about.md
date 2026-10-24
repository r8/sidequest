# About

Tuples are syntax sugar for the types `Tuple1` to `Tuple8` in `std.tuple`, so a tuple holds at most eight values.
They are _inline_ types: stored on the stack rather than allocated on the heap, which makes creating them cheap.

## Access and immutability

`pair.0`, `pair.1` and so on read a value; nested access such as `entry.2.0` works too. Tuple fields can't be
assigned, so a changed tuple is always a new one.

## Patterns

Tuples are taken apart with patterns, in `let`, in `match` and in `for` loops:

```inko
let (a, b) = (1, 2)

match (temperature, raining) {
  case (t, false) if t > 20 -> 'beach'
  case (_, true) -> 'museum'
  case _ -> 'walk'
}

for (name, score) in [('Ada', 3), ('Bob', 5)] {
  …
}
```

Matching on a tuple of two values is a common way to decide on a combination of conditions, as the
pattern-matching lesson shows.

## Ownership

Like other values, the values inside a tuple are owned by it. Destructuring an owned tuple moves its values into
the new variables; destructuring a borrowed tuple (`let (a, b) = ref pair`) gives borrows.

## Traits

A tuple implements `Equal`, `Format`, `Hash` and `Clone` whenever all of its values do, so tuples can
be compared with `==`, printed in test failures, and used as map keys.

## When to use something else

Tuples are best for two or three values whose meaning is obvious from context, such as a position or a
`(quotient, remainder)` result. When the values need names, or there are more of them, define a type with fields.
