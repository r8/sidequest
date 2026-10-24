# Introduction

A recursive function calls itself on a smaller part of its input until it reaches a base case:

```koka
fun count(xs : list<string>) : int
  match xs
    Nil -> 0
    Cons(_, rest) -> 1 + count(rest)
```

An accumulator parameter carries a running result through the calls, which makes the recursive call the last
thing the function does: a tail call, which Koka runs in constant stack space.

Koka checks termination. Recursing only on parts taken apart by a pattern, like `rest` above, always stops,
so the function is total. Recursion on a number (`n - 1`), or on a list rebuilt or shortened by a function
(`xs.drop(2)`), may not stop as far as Koka can tell: the function gets the `div` (divergence) effect, which
must be written in its type, as in `fun countdown(n : int) : div list<int>`.
