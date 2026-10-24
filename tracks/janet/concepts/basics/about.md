# About

## Everything is an expression

Janet has no statements.
`def`, `defn`, `if` and a function call are all expressions with a value, which is why a function needs no `return`: its value is the value of the last expression in its body.
Literals — numbers like `42` and `1.5`, strings like `"rye"`, `true`, `false` and `nil` — evaluate to themselves.
A _symbol_ such as `tray-capacity` evaluates to the value it is bound to.
A list in parentheses is a call: `(f a b)` evaluates `f`, `a` and `b` and then calls the first with the rest.

Some forms that look like calls are _special forms_ or _macros_ instead: `def`, `defn`, `if`, `do` and others decide for themselves which of their arguments to evaluate.
`(def x 1)` does not evaluate `x`, it binds it.

## Prefix notation

Because the operator always comes first, arithmetic needs no precedence rules and takes any number of arguments:

```janet
(+ 1 2 3 4)  # => 10
(- 10 3 2)   # => 5, that is (10 - 3) - 2
(- 5)        # => -5, one argument negates
(* 2 (+ 3 4))
```

Commas are not separators; `,` means something else entirely (unquote, used in macros).

## Comments

`#` starts a comment that runs to the end of the line.
There is no block comment syntax; the `comment` macro, `(comment …)`, ignores the forms inside it and is often used to keep REPL experiments in a file.

## `def`

`(def name value)` creates an immutable binding: the name cannot be reassigned.
Defining the same name again creates a new binding that shadows the old one for the code after it; code that already captured the old one keeps it.
For a value that changes, Janet has `var` and `set`, which a later lesson covers.

Names may contain letters, digits and the characters `!$%&*+-./:<?=>@^_`; by convention words are joined with dashes, a predicate ends in `?` (`empty?`) and a function that mutates its argument ends in `!`.
A `/` in a name, as in `string/join`, is just part of the name; by convention it groups functions of one module.

## `defn`

```janet
(defn name
  "docstring"
  [param1 param2]
  body1
  body2)
```

The docstring is optional, and so is a body of more than one expression: every expression is evaluated in order and the last one is the result.
`(doc name)` at the REPL prints the docstring.

`defn` is shorthand for binding an anonymous function: `(defn f [x] x)` is `(def f (fn [x] x))` plus the docstring and some metadata.

A function checks its arity: calling it with too few or too many arguments raises an error.
Optional and variadic parameters (`&opt`, `&`) exist, and a later lesson covers them.

## Order of definitions

Janet compiles and runs a file one top-level form at a time, so a name is visible only to the code after its definition.
Using a name that is not defined yet — even inside a function body — is a compile error (`unknown symbol`), so helpers are defined before the functions that use them.

## The REPL

Running `janet` with no arguments starts a REPL, the quickest way to try an expression.
`(doc +)` shows the documentation of any core function.
