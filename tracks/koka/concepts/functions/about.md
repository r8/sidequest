# About

## Parameters and results

A function's parameters are `name : type` pairs; its result type follows the parameter list after a colon.
Both can be inferred, but top-level functions are conventionally fully annotated. The result is the value of
the body's last expression.

Top-level functions may call each other in any order and may be recursive (a later lesson). Inside a block,
a local definition is visible only below the line that defines it.

## Default values

`name : type = value` gives a parameter a default. Callers can leave such parameters out from the end of the
argument list:

```koka
fun pad(text : string, width : int = 10, fill : string = " ") : string
  …

pad("hi")                 // width 10, fill " "
pad("hi", 4)              // fill " "
pad("hi", fill = ".")     // width 10
```

Koka accepts a default on an earlier parameter too, but then a positional call cannot skip it, so defaults belong
at the end. The standard library uses defaults widely: `pad-left(s, width, fill = ' ')`,
`throw(message, info = ExnError)`.

## Named arguments

Any parameter can be given by name at the call, `f(x, name = value)`. Positional arguments come first; named ones
follow, in any order. Names make boolean and numeric arguments self-explaining (`postage(3, express = True)`
rather than `postage(3, True)`), and they are the only way to give a later default while keeping an earlier one.
Because the parameter names are part of how a function can be called, renaming a public function's parameter can
break its callers.

## Local functions

```koka
fun frame-cost(width : int, height : int) : int
  fun side(length : int) : int
    length * 3
  2 * side(width) + 2 * side(height)
```

A local `fun` is defined inside a block and can use everything in scope at that point, including the enclosing
function's parameters and `val`s. It keeps a helper next to its only use and out of the module's namespace.

## Functions are values

A function can also be passed to and returned from other functions, and written without a name; the lesson on
higher-order functions covers that.

## Overloading

Two functions in scope may share a name if their types tell them apart (the standard library has `show` for many
types). Koka picks the right one from the argument types; a later lesson shows how to define your own.
