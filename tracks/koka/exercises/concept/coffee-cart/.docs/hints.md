# Hints

## General

- [The Koka book on data types](https://koka-lang.github.io/koka/doc/book.html#sec-data-types) shows how types
  with several constructors are declared.
- [Matching](https://koka-lang.github.io/koka/doc/book.html#sec-matching) covers patterns on constructors.

## 1. Price a cup size

- One branch per constructor of `size`.

## 2. Price a drink

- Match on the drink, and reuse `cup-price` for the cup inside a latte or a tea.

## 3. Write on the cup

- A small helper that turns a size into a word keeps `label` short.

## 4. Upsize an order

- Upsizing a size is a match of its own; then rebuild the drink with the new size and the other fields as they
  were.

## 5. Warm the milk

- A pattern can match a field against a literal, such as `False`, and a `_` branch can catch everything else.
