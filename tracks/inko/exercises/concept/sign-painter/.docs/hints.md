# Hints

## General

- The manual has a page on [strings][strings], and the standard library documents every [String method][string].

## 1. Paint a shop sign

- Interpolate both arguments into one string literal with `${…}`. Inside a single-quoted string, write the
  apostrophe as `\'`, or use double quotes for the whole string.

## 2. Tidy up an order

- There is a method that removes whitespace from both ends of a string.

## 3. Paint a market banner

- Methods can be chained: tidy first, then change the case. You can reuse `tidy`.

## 4. Count the letters to paint

- `size` counts bytes, not characters. Count the characters, after removing the spaces with `replace`.

## 5. Make a door plate

- Turn the number into a string first, then pad it at the start.

[strings]: https://docs.inko-lang.org/manual/latest/getting-started/strings/
[string]: https://docs.inko-lang.org/std/latest/module/std/string/String/
