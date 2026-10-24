# Hints

## General

- [The `std/core/string` documentation](https://koka-lang.github.io/koka/doc/std_core_string.html) lists the
  string functions.
- [The `std/core/sslice` documentation](https://koka-lang.github.io/koka/doc/std_core_sslice.html) has
  `starts-with`, `ends-with` and `capitalize`.

## 1. Print a badge

- Join the parts with `++`; one function changes the company to capitals.

## 2. Clean up the name

- Remove the spaces first, then check whether anything is left.

## 3. Label the seats

- Turn the number into a string, then pad it on the left with a zero character.

## 4. Frame the speakers' names

- The line of stars is four characters longer than the text: count the text, then repeat a star.
- `"\n"` is a new line.

## 5. Recognise the organisers

- `ends-with` does not give a `bool` by itself; ask whether it found the suffix.
