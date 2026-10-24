# Hints

## General

- The [special forms](https://janet-lang.org/docs/specials.html) page of the Janet documentation describes `quote` and `quasiquote`.
- [Macros](https://janet-lang.org/docs/macros.html) explains quasiquote, unquote and splicing with examples.
- [`symbol`](https://janet-lang.org/api/index.html#symbol) and [`eval`](https://janet-lang.org/api/index.html#eval) in the core API reference.

## 1. Name a spell

- `string/join` joins strings with a separator.
- `symbol` turns a string into a symbol.

## 2. Recognise a spell

- `tuple/type` tells parentheses from brackets, but only for tuples: check `tuple?` first.
- An empty tuple has no first element.

## 3. Write a spell

- Quasiquote with `~` and fill in the values with `,`.

## 4. Chain spells

- `,;` splices the elements of a collection into a quasiquoted form.
- The first element of the form is the symbol `do`.

## 5. Brew a potion

- Build the form with quasiquote, splicing the amounts in.
- `eval` runs a form and returns its value.
