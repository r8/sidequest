# Hints

## General

- The manual's [arrays][arrays] page introduces arrays, and the [Array][array] documentation lists every method.

## 1. Set up the shelf

- An array literal is a list of values between square brackets.

## 2. Look up a book

- `get` returns the value or an out-of-bounds error; `or` turns that into a value with a default.

## 3. Shelve a returned book

- There is a method that adds a value to the end of an array.

## 4. Lend the last book

- One method both removes the last value and returns it. Its result also needs `or` for the empty case.

## 5. Check for a book

- Arrays can tell you whether they contain a value.

## 6. Tidy the shelf

- Strings sort alphabetically, and arrays can sort themselves.

[arrays]: https://docs.inko-lang.org/manual/latest/getting-started/arrays/
[array]: https://docs.inko-lang.org/std/latest/module/std/array/Array/
