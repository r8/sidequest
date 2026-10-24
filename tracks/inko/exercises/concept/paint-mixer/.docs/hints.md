# Hints

## General

- The manual's [types][types] page describes `inline`, `copy` and `ref` types and when to use each.
- `Colour` is a `copy` type: passing it around copies it, so there's no need for borrows.

## 1. Mix two colours

- Build a new `Colour` from the averages. Mind the operator order: `(a + b) / 2`.

## 2. Lighten a colour

- Assign each field (they're `let mut`), then return `self`. A small helper method that caps a value at 255 keeps it
  short.

## 3. Print the hex code

- `Int.format(16)` writes a number in hexadecimal; `pad_start` gives it two digits.

## 4. Mix a recipe

- Start from the first colour and `reduce` over the rest, mixing as you go; `skip(1)` leaves out the first.

## 5. Copy a recipe

- Build a new `Recipe` from the fields. The array of colours needs a `clone` of its own; the name is a `String` and
  is copied anyway.

## 6. Make a variant

- Clone the colours, push the new one, and build a new recipe from them.

[types]: https://docs.inko-lang.org/manual/latest/getting-started/types/
