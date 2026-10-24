# About

## Definitions

A Koka source file is a module. Its top level holds definitions: functions (`fun`), values (`val`), types and
effects (later lessons). The order of top-level definitions does not matter — a function may call one defined
further down the file.

```koka
pub fun total-minutes(cups : int) : int
  boiling-minutes(cups) + steep-minutes

val steep-minutes = 4

fun boiling-minutes(cups : int) : int
  cups * 2
```

Inside a block, the order does matter: statements run from top to bottom, and a `val` is visible only below the
line that binds it.

## Expressions, not statements

Everything in Koka is an expression. A block's value is the value of its last expression, so a function needs no
`return`. Koka does have a `return` keyword, for leaving a function early, but it is rarely needed and most code
never uses it.

## Types and inference

Koka is statically typed and infers types: `val x = 3` gives `x` the type `int` without saying so, and a function
without a result annotation gets the result type of its body. Top-level functions are conventionally fully
annotated anyway, because the signature is the function's documentation and the anchor for clearer error
messages. Inference also needs enough information to choose between overloaded names: `fun add(a, b) a + b` is
rejected because `+` exists for both `int` and `char`; annotating one parameter resolves it.

The type `int` is an arbitrary-precision integer: it never overflows.

## Names

Identifiers are lower-case and may contain dashes between letters or digits (`minutes-left`, `cups-per-pot`, `f2`),
which is the Koka convention for multi-word names. Because of that, `a-b` is a single (and here malformed) name:
write `a - b` to subtract. Type and constructor names start with a capital letter only when they are constructors,
as later lessons show.

## Layout

Koka uses layout: an indented block after a header is the body, and statements on separate lines need no
separators. The same code can be written with braces and semicolons:

```koka
fun quadruple(n : int) : int { val twice = n * 2; twice * 2 }
```

A short body can also follow the header on the same line, as in `fun double(n : int) n * 2` (without a result
annotation) or in braces.

## Visibility

Top-level definitions are private to their module unless marked `pub`. A module's public functions are what an
`import` of it can use.

## Comments

`//` comments to the end of the line; `/* … */` comments may span lines and nest. A `//` comment directly above a
definition is its documentation.
