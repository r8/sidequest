# Introduction

In Koka, `x.f(y)` is another way of writing `f(x, y)`, and `x.f` means `f(x)`. This _dot-selection_ works for
every function, so a series of calls can read left to right in the order they happen:

```koka
inc(double(abs(-4)))     // 9
(-4).abs.double.inc      // 9
```

There are no methods behind it: the dot only moves the first argument in front of the function name. The dot
binds to the expression just before it, so `1 + 2.double` is `1 + double(2)`; parenthesise a larger expression,
`(1 + 2).double`.
