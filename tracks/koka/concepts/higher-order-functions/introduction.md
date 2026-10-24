# Introduction

Functions are values: they can be passed to functions and returned from them. A function type is written
`(int) -> bool`, parameter types on the left of the arrow and the result on the right. A function that takes a
function is a higher-order function:

```koka
fun apply-twice(f : (int) -> int, x : int) : int
  f(f(x))
```

Pass a named function by its name (`apply-twice(double, 5)`), or write one in place with `fn`:
`apply-twice(fn(n) n + 1, 5)`. An anonymous function can use the values around it.

The list functions of the standard library are built this way: `map`, `filter`, `any`, `all`, `find`, and
`foldl`/`foldr`, which combine all elements into one result.
