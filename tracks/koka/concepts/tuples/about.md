# About

## Tuple types

`(a, b)` is a pair, `(a, b, c)` a triple, and so on; the types of the parts may differ. The empty tuple `()` is
the _unit_ value, the result of functions that return nothing interesting, and its type is also written `()`.
There is no one-element tuple: `(x)` is just `x` in parentheses.

## Taking tuples apart

A pair's parts are `.fst` and `.snd`, and a triple also has `.thd`. Patterns are the general way, and read
better once the parts have meanings:

```koka
val (name, paces, found) = ("palm", 12, False)

fun swap((x, y) : (int, string)) : (string, int)
  (y, x)

fun describe(p : (int, int)) : string
  match p
    (0, 0) -> "at camp"
    (x, _) | x > 0 -> "east"
    _ -> "west"
```

A pattern in a parameter or a `val` must always fit — a tuple pattern of names always does.

## Comparing and showing

The standard library defines `==`, `cmp` and `show` for tuples of up to five parts, provided the parts have
them, so `(1, "a") == (1, "a")` and `(1, 2).show == "(1,2)"` work out of the box. Tuples order
lexicographically: the first parts decide unless they are equal.

## When to use something else

Tuples are anonymous: `(int, int)` does not say which number is the row. For values that travel far through a
program, a `struct` with named fields (a later lesson) documents itself better. Tuples shine for short-lived
groupings: returning two results, or matching on two values at once, as in `match (x, y)`.
