# About

## The type

`either<a,b>` is an ordinary algebraic data type from `std/core/types`, with two constructors:

```koka
type either<a,b>
  Left(left : a)
  Right(right : b)
```

It is the standard way to return "a result or a reason why not". The convention — `Right` for the right answer,
`Left` for the failure — is only a convention, but the standard library follows it: `.maybe` keeps the `Right`
side, and `map` (from a later lesson on higher-order functions) changes only a `Right`'s value:

```koka
check-age(30).map(fn(a) a + 1)    // Right(31)
check-age(-1).map(fn(a) a + 1)    // Left("age cannot be negative")
```

## Maybe, either, exceptions

- `maybe<a>` when absence needs no explanation (`find`, `head`, `parse-int`).
- `either<e,a>` when the caller should learn why, and decide what to do about it.
- Exceptions (the `exn` effect, a later lesson) when failure should skip straight to some handler further up,
  rather than being passed back by every caller. Koka's `try` turns an exception into an `error<a>`, which is a
  `result` with `Ok` and `Error` constructors — the same idea as either, with the sides named.

## Chaining

Koka has no special syntax for chaining eithers. A sequence of checks is a nest of matches, where each `Left` is
rebuilt so that its type fits the result:

```koka
match check-age(a)
  Left(problem) -> Left(problem)
  Right(x) -> …
```

When the chain grows long, a small helper that takes the next step as a function keeps it flat:

```koka
fun and-then(e : either<string,a>, next : (a) -> either<string,b>) : either<string,b>
  match e
    Left(problem) -> Left(problem)
    Right(x) -> next(x)
```

## Pitfalls

- A `match` that leaves out a constructor compiles, but adds the `exn` effect to the function, since the missing
  case would fail at run time. If the function's type says it is total, the compiler rejects it.
- Both sides must have a type: a bare `Left("oops")` has an unknown right side until the context fixes it, so give
  the function a result type.
- When both sides have the same type, swapping them type-checks. Keep `Right` for success.
