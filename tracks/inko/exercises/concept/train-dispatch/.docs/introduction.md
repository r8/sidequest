# Introduction

`match` compares a value against a list of _patterns_ and runs the body of the first one that fits:

```inko
match number {
  case 0 -> 'zero'
  case 1 -> 'one'
  case _ -> 'many'
}
```

Each `case` has a pattern, `->`, and a body. A body that needs more than one expression goes in braces. Like `if`,
`match` is an expression: its value is the value of the body that ran, so every body must produce the same type.

## Literal patterns and the wildcard

`Int`, `String` and `Bool` literals match equal values. `_` is the _wildcard_: it matches anything. Matches must
be _exhaustive_, covering every possible value, so a match on an integer or a string always needs a `_` case at the
end (a match on a `Bool` can list `true` and `false` instead). The compiler rejects a match with missing cases,
and warns about cases that can never be reached.

`or` combines patterns that share a body:

```inko
match day {
  case 'Saturday' or 'Sunday' -> 'weekend'
  case _ -> 'weekday'
}
```

## Bindings

A name in a pattern matches anything and binds the value to that name, for use in the body:

```inko
match count {
  case 0 -> 'none'
  case n -> '${n} items'
}
```

## Guards

`if` after a pattern adds a condition, a _guard_. The case only matches when the pattern fits and the guard is
true. Guards are how you match ranges of numbers:

```inko
match temperature {
  case t if t < 0 -> 'freezing'
  case t if t < 20 -> 'mild'
  case _ -> 'warm'
}
```

## Tuples

A tuple pattern matches each value of a tuple against its own pattern. Matching on a tuple built on the spot is a
neat way to decide on several values at once:

```inko
match (raining, temperature > 20) {
  case (true, _) -> 'umbrella'
  case (false, true) -> 'sunglasses'
  case (false, false) -> 'jacket'
}
```

Since every combination of two booleans is covered, this match needs no wildcard.

## Options

An `Option` is matched by its cases, `Some(…)` and `None`, written without `Option.` in front. The pattern
inside `Some` binds or matches the value it holds:

```inko
match Int.parse(input, 10) {
  case Some(0) -> 'zero'
  case Some(n) -> 'the number ${n}'
  case None -> 'not a number'
}
```

When `Some` and `None` are both covered, the match is exhaustive. The same works for `Ok(…)` and `Error(…)`.

## Nesting

Patterns nest as deep as you like, mixing literals, bindings, wildcards and cases:

```inko
match order {
  case ('tea', Some(sugar)) if sugar > 2 -> 'very sweet tea'
  case ('tea', _) -> 'tea'
  case (drink, None) -> '${drink}, no sugar'
  case (drink, Some(_)) -> '${drink} with sugar'
}
```

## Matching with let

`let` also takes a pattern. A pattern that always matches, such as a tuple pattern, just destructures. A pattern
that might not match, such as `Some(…)`, needs an `else` that leaves the method (or panics) when it doesn't:

```inko
fn pub double(input: String) -> Int {
  let Some(number) = Int.parse(input, 10) else return 0

  number * 2
}
```

This keeps the "happy path" flat when several steps may each fail.

## Arrays

Array patterns match arrays of an exact size: `case [] -> …`, `case [only] -> …`, `case [first, second] -> …`.
They can't match "two or more" values, so they always need a wildcard case too.
