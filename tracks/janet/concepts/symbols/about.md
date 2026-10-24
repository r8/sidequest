# About

## Symbols in code and as data

The parser turns every bare name in the source — `x`, `string/join`, `+`, `empty?` — into a symbol.
The compiler then resolves each symbol: a local binding, a top-level `def` or `var`, a core function, or a special form like `if`.
An unresolvable symbol is the compile error "unknown symbol".

As data, symbols are produced by quoting (`'name`, `(quote name)`) or by the `symbol` function, which concatenates its arguments' string forms: `(symbol "item-" 3)` is `item-3`.
They compare with `=` by name, can be table keys, and convert with `string`, `keyword` and `symbol`.

## Symbols and keywords

| | keyword `:a` | symbol `'a` |
| --- | --- | --- |
| evaluates to | itself | the value bound to `a` |
| predicate | `keyword?` | `symbol?` |
| typical use | table keys, enumerations, options | names in code, macros |

Both are interned, so equality is a pointer comparison and they are cheap as keys.

## Unique symbols

`(gensym)` returns a symbol guaranteed not to clash with any other in the program, such as `_00000Y`.
Macros use it to introduce bindings that cannot capture the caller's names.

## Names with slashes

A symbol like `string/join` is one symbol; the slash is part of its name.
Importing a module with `(import ./units :as u)` makes bindings named `u/to-grams`, and so on.

## The environment

Top-level bindings live in an _environment_ table keyed by symbol.
`(curenv)` is the current one; `(get (curenv) 'x)` is the entry for `x`, a table with `:value` (or `:ref` for a `var`) and metadata such as `:doc`.
`eval` and `macex` resolve symbols in the current environment.
