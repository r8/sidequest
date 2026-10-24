# About

## Code is data

The parser reads source text into ordinary values: numbers, strings, keywords, symbols, and tuples (for `( )` and `[ ]`), structs (`{ }`) and their `@`-prefixed mutable counterparts.
The compiler then turns those values into bytecode.
A Lisp lets you sit between the two steps: build or transform the values yourself, then hand them to the compiler with `eval` or, more usually, from a macro.

## The four quoting forms

| Reader syntax | Long form | Meaning |
| --- | --- | --- |
| `'x` | `(quote x)` | `x`, unevaluated |
| `~x` | `(quasiquote x)` | `x`, unevaluated except for unquoted parts |
| `,x` | `(unquote x)` | inside `~`: the value of `x` |
| `,;x` | `(unquote (splice x))` | inside `~`: the elements of `x`, spliced in |

Quasiquotes can nest, which macro-writing macros need: each level of `~` is undone by one level of `,`.
Unquote outside a quasiquote is a compile error ("cannot use unquote here").

`;` alone is splice, usable in any call or tuple/array literal: `(+ ;xs)`, `[0 ;xs]`.

## Tuples remember their brackets

`(a b)` and `[a b]` both read as tuples; the compiler treats the first as a call and the second as a tuple literal.
`tuple/type` returns `:parens` or `:brackets`, and `tuple/brackets` builds a bracketed tuple.
Quasiquoted parentheses produce `:parens` tuples, as the source did.
`=` distinguishes the two kinds; `deep=` does not.

## `eval` and friends

- `(eval form)` compiles and runs `form` in the current environment and returns its value.
- `(eval-string "(+ 1 2)")` parses a string first.
- `(parse "(+ 1 2)")` returns the form without running it.
- `(macex form)` expands every macro in `form`; `(macex1 form)` expands only the outermost one. Both are the best way to see what a macro writes.

`eval` is a tool for REPLs, configuration and learning.
Ordinary programs build code with macros, which run at compile time; a program that calls `eval` on data from outside runs whatever that data says.

## Printing forms

`pp` and `(string/format "%q" form)` print a form in source notation, so a generated form can be read back: `(string/format "%q" '(+ 1 2))` is `"(+ 1 2)"`.
