# About

## What a keyword is

A keyword is an immutable, interned byte sequence of type `:keyword`, written with a leading colon.
It evaluates to itself, so `:ok` needs no quoting.
Interning means every occurrence of `:ok` is the same object, so equality is a pointer comparison and keywords are ideal as table keys and as members of a fixed set of values.

Any characters allowed in a symbol are allowed after the colon: `:high-tide`, `:ok?`, `:2nd`.
The bare `:` is a keyword too, the empty one.
`(keyword "two words")` can make a keyword that has no literal syntax, which is rarely a good idea.

## Keywords and strings

Keywords and strings are both byte sequences, but they are different types and never equal.
`string` converts a keyword to a string (dropping the colon), `keyword` converts strings and other values into a keyword (`(keyword "a" 1)` is `:a1`), and `describe` gives the printed form with the colon, `":ok"`.

Functions that read byte sequences accept keywords: `(length :abc)` is `3` and `(string/has-prefix? "ab" :abc)` is `true`.
Functions that produce text produce strings, never keywords.

Keywords order alphabetically with `<`, `>` and `compare`, like strings.

## Idioms

- **Enumerations.** Return `:low`, `:mid` or `:high` rather than numbers or strings, and dispatch on them with `case` or `match`.
- **Table and struct keys.** `{:name "Ada" :born 1815}` is the usual shape of a record, and the data-structure lessons use keywords this way throughout.
- **Named arguments.** Functions declared with `&named` or `&keys` take keyword–value pairs: `(describe-order "latte" :size :large)`.
- **Results.** A function can return a pair such as `[:ok value]` or `[:error message]` that the caller matches on.

## Keywords as methods

A keyword in function position is a _method call_: `(:speak dog)` looks up `:speak` in the table `dog` (and its prototypes) and calls the function found there with `dog` as the first argument.
On a value that has no such method it is an error, so `(:name person)` does not read a field the way it would in Clojure; `(person :name)` or `(get person :name)` does.
The prototypes lesson covers methods.

## Keywords and symbols

A _symbol_ looks like a keyword without the colon, but it is a name that refers to something: `sunny` is looked up when evaluated, `:sunny` is not.
Symbols are the subject of a later lesson on quoting and macros.
