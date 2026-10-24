# Introduction

`var` declares a local variable that can change, and `:=` both initialises and assigns it:

```koka
fun sum-to(n : int) : int
  var total := 0
  for(1, n) fn(i)
    total := total + i
  total
```

A `var` belongs to the function that declares it. Lambdas inside the function may read and assign it, but it can
never escape the call, so the function keeps a pure type — `sum-to` is still a total `int` function. Only `var`s can
be assigned; a `val` never changes.
