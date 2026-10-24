# Introduction

Janet is a Lisp: a program is made of _expressions_, and almost every expression is a list in parentheses whose first element says what to do.
There are no statements and no operator precedence to remember.

## Expressions

A number, a string or a name on its own is an expression that evaluates to itself (or, for a name, to the value it is bound to).
Anything else is written in _prefix notation_: the function first, then its arguments, all inside parentheses and separated by spaces.

```janet
(+ 1 2)          # => 3
(* 4 5)          # => 20
(- 10 3)         # => 7
(+ 1 2 3 4)      # => 10, arithmetic functions take any number of arguments
(* 2 (+ 3 4))    # => 14, expressions nest; the inner one is evaluated first
```

Commas are not separators in Janet: `(+ 1, 2)` is an error.
Whitespace, including newlines, is all you need between arguments.

## Comments

A comment starts with `#` and runs to the end of the line.

```janet
# The whole line is a comment.
(+ 1 1) # So is the rest of this one.
```

## Naming values with `def`

`def` binds a name to a value.
The binding is permanent: you cannot assign a new value to a name made with `def`.

```janet
(def loaves-per-tray 6)
(def trays 4)

(* loaves-per-tray trays) # => 24
```

Names in Janet can contain letters, digits and most punctuation: `loaves-per-tray`, `ready?` and `set-timer!` are all ordinary names.
By convention, words in a name are separated with dashes (`kebab-case`).

## Defining functions with `defn`

`defn` defines a named function.
It takes the function's name, an optional documentation string, the parameters in square brackets, and then the body.

```janet
(defn loaves
  "Returns how many loaves fit on the given number of trays."
  [trays]
  (* trays 6))

(loaves 3) # => 18
```

There is no `return` keyword.
A function returns the value of the last expression in its body.

A function can have several parameters, or none at all:

```janet
(defn area
  "Returns the area of a rectangle."
  [width height]
  (* width height))

(defn greeting
  "Returns the bakery's greeting."
  []
  "Good morning!")

(area 3 4)   # => 12
(greeting)   # => "Good morning!"
```

Calling a function with the wrong number of arguments is an error, so `(area 3)` fails rather than quietly returning something odd.

Functions can use the values defined with `def` and call one another, as long as each name is defined before the code that uses it runs.
A name defined at the top of a file is visible to everything below it:

```janet
(def tray-capacity 6)

(defn loaves
  "Returns how many loaves fit on the given number of trays."
  [trays]
  (* trays tray-capacity))

(defn loaves-for-week
  "Returns the loaves baked in a week, with the given number of trays a day."
  [trays]
  (* 7 (loaves trays)))

(loaves-for-week 2) # => 84
```

## Docstrings

The string between the name and the parameters is the function's _docstring_.
It is optional, but it is good practice, and the REPL shows it: `(doc loaves)` prints the docstring of `loaves`.
In this track, every function's docstring starts with its signature, such as `"(loaves trays) -> integer"`.

## Pitfalls

- Every parenthesis matters. `(greeting)` calls the function; `greeting` on its own is the function itself, not its result.
- `-` with a single argument negates it: `(- 5)` is `-5`. With two or more it subtracts the rest from the first: `(- 10 3 2)` is `5`.
- `def` is not assignment. Defining the same name again in the same file shadows the old binding instead of changing it, which is rarely what you want.
