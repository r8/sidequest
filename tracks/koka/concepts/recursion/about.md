# About

## Shape of a recursive function

Every recursive function needs a base case that answers without recursing, and recursive cases that move
towards it. On lists the patterns `Nil` and `Cons(x, rest)` give both; patterns that look further ahead, such as
`Cons(a, more as Cons(b, _))`, process elements in pairs while still recursing on a pattern variable.

## Totality and the `div` effect

Koka infers whether a function may run forever. When every recursive call is on a sub-term of an argument —
a value bound by a pattern inside it — the function is _total_. Anything else gets the `div` effect:

| Recursive call | Effect |
| --- | --- |
| `f(rest)` where `Cons(_, rest)` was matched | total |
| `f(more)` where `more as Cons(_, _)` was matched | total |
| `f(n - 1)` on an `int` | `div` |
| `f(Cons(b, rest))`, `f(xs.drop(2))`, `f(xs.tail)` | `div` |

A function with `div` must say so in its type (`: div int`); a function calling it gets `div` too. When `div`
is missing from an annotation, the compiler reports "effects do not match" with the inferred effect `total` and
the expected `<div|_e>`: read it as "the body needs `div`".

`div` is harmless in practice — it only records that termination is not proven — but keeping functions total
where it is natural documents that they always finish. Recursion on numbers is the common reason to accept it.
Mutually recursive functions are also always inferred as `div`.

## Tail calls and accumulators

A call in tail position (the last thing a function does) does not grow the stack: Koka compiles
self-recursive tail calls into jumps. Rewriting `1 + count(rest)` as `go(rest, acc + 1)` with an accumulator
makes a function safe for very long inputs. Accumulating into a list builds it in reverse, so such functions
often end with `.reverse`.

Koka also optimises some calls that are not in tail position, such as building a list with
`Cons(x, f(rest))` ("tail recursion modulo cons"), so the natural recursive definition of a list-producing
function is efficient too.

## Recursion versus library functions

The standard library already covers the common recursions over lists — `sum`, `length`, `reverse`, and the
higher-order `map`, `filter` and `foldl` of a later lesson. Write recursion by hand when the shape of the
problem is unusual, such as looking at neighbouring elements.
