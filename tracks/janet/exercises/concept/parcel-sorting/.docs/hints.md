# Hints

## General

- [`match`](https://janet-lang.org/api/index.html#match) in the core API describes every kind of pattern; `(doc match)` at the REPL shows the same text.
- [Destructuring](https://janet-lang.org/docs/destructuring.html) covers the bracket and struct shapes that patterns share.

## 1. Work out the postage

- A guarded pattern in parentheses can check the weight; try the lighter letters first.
- Full kilograms: integer division with `div`.
- A final `_` pattern handles anything that is not a known item.

## 2. Route by address

- A struct pattern can contain literal values as well as names.
- The specific countries must come before the pattern that matches any country.

## 3. Read the stickers

- `& items` at the end of a bracket pattern binds the rest of the tuple, which may be empty.
- Remember that `[:fragile]` also matches a tuple with more elements after `:fragile`.
- `string/join` turns the items into one string.

## 4. Pick the parcels for a depot

- Patterns nest: a struct pattern can contain another struct pattern.
- To compare with the city passed in rather than bind a new name, use `(@ name)`.
