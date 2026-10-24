# Introduction

A Koka function type records the function's _effect_ — what it may do besides returning a value — just before
the result type:

```koka
fun square(n : int) : total int          // nothing: `: int` means the same
fun greet(name : string) : console ()   // prints
fun half(n : int) : exn int             // may throw
```

The common effects are `total`, `exn`, `div` (may not terminate), `pure` (`<exn,div>`), `console` and `io`.
Effects are inferred, and checked where you write them: a function declared total cannot print. Higher-order
functions take an _effect variable_ and pass it on, `fun twice(f : (int) -> e int, x : int) : e int`, and an
open row `<exn|e>` adds an effect of the function's own to the ones it inherits — the parameter must then be
`(int) -> <exn|e> int` too.
