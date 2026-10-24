# Hints

## General

- The Janet documentation's [strings](https://janet-lang.org/docs/strings.html) page describes string literals.
- The [string module](https://janet-lang.org/api/string.html) lists every `string/` function.

## 1. Print the main line

- `string` joins any number of pieces into one string.
- There is a `string/` function that turns letters into capitals.

## 2. Print the initials

- `string/slice` with the right indexes returns a one-letter string.
- The surname starts right after the space; `string/find` tells you where the space is.

## 3. Find the surname

- `string/slice` without an end index runs to the end of the string.

## 4. Print the name tag

- `string/format` can pad a value to a width, and align it to the left.
- For `%s`, the precision limits how many bytes are printed.

## 5. Spot the doctors

- One `string/` function checks how a string begins. Mind the order of its arguments.
