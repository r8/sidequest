# Introduction

## Functions and values

A Koka program is a module: a file of definitions. The most common definition is a function, introduced with
`fun`, followed by its name, its parameters in parentheses, and after a colon the type of its result:

```koka
fun double(n : int) : int
  n * 2
```

The body is the indented block below the header. There is no `return` statement to write: the value of the last
expression in the block is the function's result.

Functions are called with their arguments in parentheses, separated by commas:

```koka
double(21)        // 42
```

## Names

Koka names may contain dashes, so `minutes-left` and `cups-per-pot` are single names. That makes a minus sign
written without spaces part of a name: `left-1` is a syntax error, while `left - 1` subtracts. Always put spaces
around `-`.

## Values

`val` gives a name to a value, inside a function or at the top level of a module:

```koka
val cups-per-pot = 4

fun cups-for(pots : int) : int
  val cups = pots * cups-per-pot
  cups + 1    // and one spare
```

A `val` cannot be reassigned: once `cups` is bound, it always means the same value. The statements of a block run
from top to bottom, each `val` can use the ones before it, and the block's last line is its result.

## Types

Every value has a type. Whole numbers have the type `int`, and the arithmetic operators `+`, `-` and `*` work on
them with the usual precedence (`2 + 3 * 4` is `14`). Parameters are written `name : type`.

Koka infers the types you leave out, so this is a valid function too:

```koka
fun triple(n : int)
  n * 3
```

Its result type is inferred to be `int`. Writing the types of a function's parameters and result is still the
convention for anything you define at the top level: it documents the function and gives better error messages.
Some operators also need to know the types: `+` works on both numbers and characters, so in

```koka
fun add(a, b)
  a + b
```

Koka cannot tell which `+` you mean and reports that it "cannot be resolved". Annotating `a : int` fixes it.

## Layout

Blocks are marked by indentation, as in the examples above. Braces work too, and a semicolon separates
statements on one line:

```koka
fun quadruple(n : int) : int { val twice = n * 2; twice * 2 }
```

The indented style is the usual one; use two spaces per level.

## Visibility

Definitions are private to their module unless they are marked `pub`. A function that other modules — such as
the tests — call must be `pub`:

```koka
pub fun greeting() : string
  "Hello"
```

## Comments

`//` starts a comment that runs to the end of the line, and `/* … */` encloses a comment of any length.
A comment just above a definition documents it.
