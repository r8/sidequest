# About

## Effects in types

Koka's function types have the form `(parameters) -> effect result`. The effect is a _row_ of effect labels,
`<exn,div>`, with `<>` (named `total`) the empty row. A function's effect is everything that may happen when it is
called: the effects of the functions it calls, minus the ones it handles. Because purity is visible in the type, a
total function can be cached, reordered or run in parallel without changing the program.

## The built-in effects

| Effect | Meaning |
| --- | --- |
| `total`, `<>` | none |
| `exn` | may throw an exception |
| `div` | may diverge: recursion Koka cannot prove terminating, `while` loops |
| `pure` | `<exn,div>` |
| `ndet` | non-deterministic, such as random numbers |
| `console`, `fsys`, `net`, `ui` | the console, the file system, the network, the user interface |
| `st<h>` | reading, writing and allocating references in the heap `h` |
| `io` | `<exn,div,ndet,console,net,fsys,ui,st<global>>`: everything a `main` may do |

`local<h>`, the effect of a function's `var`s, is removed again when the function returns, which is why a function
using `var` internally can still be total.

## Inference

Effects are inferred along with types. An unannotated function gets an _open_ row — `fun warn(n)` that throws and
prints is inferred as `(n : int) -> <console,exn|e> ()`, usable wherever at least those effects are allowed. An
annotation is checked: if the body may do more than the declared effect, the error is "effects do not match".

## Effect polymorphism

An effect variable such as `e` makes a higher-order function as total or as effectful as its argument:

```koka
fun twice(f : (int) -> e int, x : int) : e int
  f(f(x))
```

All of the library's list functions are written this way, which is why `xs.map(fn(x) …)` works with lambdas that
throw, print or use handlers defined later in this track.

The body of a function has one effect row, and every call in it must fit that row. A function that calls `f` and
also throws needs `f : (a) -> <exn|e> b` with result effect `<exn|e>`; with `f : (a) -> e b` the `e` is fixed by
the caller and `throw` does not fit. A total function can always be passed where an effectful one is expected.

## Duplicated labels

Rows may contain a label twice: `<exn|e>` with `e` instantiated to `<exn>` is `<exn,exn>`, which is not the same as
`<exn>` and does not fit into `io`. It matters mainly for handlers (an inner and an outer handler of the same
effect) and shows up when a stub's `<exn|e>` meets a caller whose function already throws: write the parameter
with the same `<exn|e>` row to avoid it.

## Why it matters

Effect types are what make Koka's effect handlers safe: an operation like `throw` or one you define yourself
appears in the type until a handler removes it, so the compiler knows that every effect is handled.
