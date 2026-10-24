# Introduction

## Functions with several parameters

A function takes any number of parameters, each with its type, separated by commas:

```koka
fun area(width : int, height : int) : int
  width * height
```

A function can call any other top-level function in its module, whether it is defined above or below.

## Default values

A parameter can have a default value, written after its type. A call may then leave it out:

```koka
fun greet-cost(words : int, urgent : bool = False) : int
  if urgent then words * 2 else words

greet-cost(10)          // 10
greet-cost(10, True)    // 20
```

Put the parameters with defaults last: a call can only leave out a positional argument at the end.

## Named arguments

Any argument can be passed by the parameter's name, as `name = value`. This makes calls with several
booleans or numbers readable, and lets you give a later optional parameter while skipping the earlier ones:

```koka
fun label(copies : int, color : bool = False, large : bool = False) : int
  copies + (if color then 10 else 0) + (if large then 5 else 0)

label(2, large = True)              // 7
label(copies = 2, color = True)     // 12
```

Positional arguments come first; named ones may follow in any order.

## Local functions

A function body may define its own helper functions with `fun`, before using them. A local function can see
the parameters and `val`s of the function around it, so it often needs fewer parameters of its own:

```koka
fun frame-cost(width : int, height : int) : int
  fun side(length : int) : int
    length * 3
  val corners = 4
  2 * side(width) + 2 * side(height) + corners
```

A local function is invisible outside its body, which keeps small helpers next to the one place they are
used.

## Dot-selection

Koka lets you write the first argument of any call in front of the function's name, followed by a dot:

```koka
x.f(y, z)    // the same as f(x, y, z)
x.f          // the same as f(x)
```

This is _dot-selection_ (sometimes called uniform function call syntax). It is purely a way of writing calls:
there are no methods, no classes, nothing attached to the value. It works for every function, the standard
library's and your own:

```koka
fun double(n : int) : int
  n * 2

4.double         // 8
10.max(3)        // 10, the same as max(10, 3)
```

Its real benefit is _chaining_. Calls read from left to right in the order they happen, instead of inside out:

```koka
inc(double(abs(-4)))     // 9
(-4).abs.double.inc      // 9
```

The standard library is written to be used this way: `abs`, `min`, `max`, `inc` (add one) and `dec` (subtract
one) are ordinary functions, and so is `show`, which turns a value into a string (`42.show` is `"42"`).

The dot applies to the expression just before it, so `1 + 2.double` is `1 + 4`. To apply it to a whole
calculation, use parentheses: `(1 + 2).double` is `6`. A negative number literal is fine on its own:
`-4.abs` is `4`.

Named and default arguments work as usual with dot-selection: `3.label(color = True)` is `label(3, color = True)`.

## Choosing a style

Use whichever form reads best. Dot-selection suits a value that flows through a series of steps and a function
whose first parameter is "the thing being worked on"; the plain form suits functions whose arguments are equals,
such as `area(width, height)`.
