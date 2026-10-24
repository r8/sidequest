# About

## Function types

`(a, b) -> c` is the type of a function taking an `a` and a `b` and returning a `c`; `() -> c` takes nothing.
Function types are full types: they appear in parameters, results, lists (`list<(int) -> int>`) and tuples.
In full, a function type also says which _effects_ the function may have, such as throwing an exception or
diverging; the plain form `(int) -> int` is a total function. Writing parameters with an effect variable,
`(int) -> e int`, so that callers may pass any function, is the subject of the effect types lesson.

## Anonymous functions and closures

`fn(x, y) body` is a function without a name. Its parameter types are inferred from the context or annotated
(`fn(x : int) …`). The body may use any value in scope where the `fn` is written, and keeps it: a function can
return a function that remembers its argument.

```koka
fun adder(n : int) : ((int) -> int)
  fn(x) x + n

val add3 = adder(3)    // add3(4) == 7
```

## Passing named functions

A top-level function is passed by its name: `xs.map(show)`, `xs.filter(is-even)`, `xs.map(inc)`. When a name is
overloaded for several types, Koka picks by the expected type; where it cannot, wrap it in a `fn` with an
annotation, or qualify the name.

## The list toolkit

| Function | Purpose |
| --- | --- |
| `map(f)` | transform every element |
| `filter(p)`, `remove(p)` | keep / drop the elements satisfying `p` |
| `partition(p)` | both at once, as a pair of lists |
| `any(p)`, `all(p)` | does some / every element satisfy `p` (`all` is `True` for `[]`) |
| `find(p)` | the first match, as a `maybe` |
| `filter-map(f)` | `f` returns a maybe; keep the `Just` values |
| `flatmap(f)` | `f` returns a list; concatenate them |
| `foldl(init, f)` | `f(acc, x)` from left to right |
| `foldr(init, f)` | `f(x, acc)` from right to left |
| `foreach(f)` | run `f` for its effect on every element |
| `take-while(p)`, `drop-while(p)` | the prefix satisfying `p`, or what follows it |
| `map-indexed(f)` | `f(index, x)` |

`foldl` can express most of the others; prefer the specific function when there is one, since it says what the
code means.

## Building your own

Higher-order functions are ordinary functions with function parameters. Writing one is the way to name a
pattern that recurs in a program: "count the elements that pass a test", "apply a list of adjustments in
order".
