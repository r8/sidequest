# Introduction

## Every function has an effect

In most languages a function's type says what it takes and what it returns. Koka's also says what it may _do_
on the way: its _effect_. The effect is written just before the result type:

```koka
fun square(n : int) : total int       // only computes
  n * n

fun greet(name : string) : console () // prints
  println("Hello, " ++ name)

fun half(n : int) : exn int           // may throw an exception
  if n % 2 == 1 then throw("odd") else n / 2
```

`throw("odd")` stops the function with an exception carrying the message `"odd"`; the stubs of every exercise
use it to say `implement me`, which is why their types say `exn`. The next lesson is about catching exceptions.

A result type with no effect, as in `fun square(n : int) : int`, means `total`: the function always returns,
does nothing else, and gives the same result for the same arguments.

## The common effects

| Effect | Meaning |
| --- | --- |
| `total` (or `<>`) | no effect at all |
| `exn` | may throw an exception |
| `div` | may not terminate (the recursion lesson met it) |
| `pure` | `<exn,div>`: may throw or loop, nothing else |
| `console` | reads or writes the console, as `println` does |
| `io` | anything: console, files, exceptions, divergence, … |

Several effects together form a _row_, written in angle brackets: `<exn,div>`, `<console,exn>`. The order does
not matter.

## Inference and checking

Like types, effects are inferred. A function without a result annotation gets the effect of everything it calls:

```koka
fun warn(n : int)
  if n > 0 then throw("too big") else println("fine")
```

is inferred to have the effect `<console,exn>` (strictly, the open row `<console,exn|e>`, explained below, so
it can be called wherever those two effects are allowed). When you do write an effect, Koka checks it. A function declared
total that prints is rejected:

```koka
fun loud(n : int) : int
  println("hi")        // error: effects do not match
  n
```

So the type of a function is a promise you can rely on: an `int -> int` cannot print, throw or loop, whatever is
inside it.

## Effect variables

A higher-order function calls functions it is given, and so inherits whatever they do. Writing a parameter as
`(int) -> int` demands a total function — passing a lambda that throws is an error. Instead, give it an _effect
variable_, a lower-case name in the effect position, just like a type variable:

```koka
fun twice(f : (int) -> e int, x : int) : e int
  f(f(x))
```

This reads "for any effect `e`: given a function with effect `e`, `twice` has effect `e` too". So
`twice(square, 3)` is total, and `twice(half, 4)` has the effect `exn`. The library's `map`, `filter`, `foldl`
and friends are all declared this way, as `map(xs : list<a>, f : (a) -> e b) : e list<b>`.

## Open rows

A function can add effects of its own to the ones it inherits. `<exn|e>` is the row "`exn`, and whatever `e`
is":

```koka
fun checked(f : (int) -> <exn|e> int) : <exn|e> int
  val result = f(1)
  if result < 0 then throw("negative") else result
```

Note that the parameter's type says `<exn|e>` as well. A function's body has a single effect, and calling `f` and
throwing both take place in it, so `f`'s effect has to be the whole row. Writing `f : (int) -> e int` here makes
`throw` an error: the effect `e` is fixed by the caller and might not include `exn`. A total function, such as
`square`, can still be passed: `checked(square)` is fine.

That is also why the stubs say `(a) -> <exn|e> b` where the solution may only need `(a) -> e b`: a stub throws
`implement me` besides calling the function.
