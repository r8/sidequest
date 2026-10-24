# Introduction

Koka has no `null`. A value that may be missing has the type `maybe<a>`: either `Just(x)`, holding an `x` of
type `a`, or `Nothing`. Functions such as `head`, list indexing `xs[i]` and `parse-int` return one, and your
own functions return one when they may have no answer.

A `maybe<int>` is not an `int`, so the compiler makes you deal with the missing case before using the value —
usually with a `match`:

```koka
fun describe(m : maybe<int>) : string
  match m
    Just(n) -> "found " ++ n.show
    Nothing -> "nothing there"
```

or with a shortcut: `m.default(0)` gives the value or `0`; `m.is-just` and `m.is-nothing` say which case it is.
