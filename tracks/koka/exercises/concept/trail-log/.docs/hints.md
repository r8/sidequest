# Hints

## General

- [The Koka book on effect types](https://koka-lang.github.io/koka/doc/book.html#sec-effect-types) explains `div` and why recursion on numbers needs it.
- [The Koka book on the semantics of effects](https://koka-lang.github.io/koka/doc/book.html#sec-semantics-of-effects) describes what divergence means.

## 1. Add up the distance

- The empty list has a distance of `0`; a list with a first leg adds that leg to the distance of the rest.

## 2. Find the longest leg

- `max(a, b)` gives the larger of two numbers.

## 3. Measure the climb

- Match the first two altitudes with `Cons(a, more as Cons(b, _))` and recurse on `more`.
- `max(rise, 0)` ignores a descent.

## 4. Plan the waymarks

- Build the list with `Cons(n, …)` and recurse on `n - 1`.
- Recursion on a number needs the `div` effect in the result type.
