# Hints

## General

- [The std/core/char module](https://koka-lang.github.io/koka/doc/std_core_char.html) lists the functions on characters.
- [The Koka book on literals](https://koka-lang.github.io/koka/doc/book.html#sec-literals) shows how characters are written.

## 1. Spot the vowels

- `match` can have one branch per vowel; or check whether the vowels in a string, as a list, contain the character.

## 2. Make a capital

- `is-lower` tells whether to change the character.
- An upper-case letter's code point is that of its lower-case letter minus the distance from `'a'` to `'A'`.

## 3. Count the digits

- `is-digit` is a ready-made test to pass to a counting function.

## 4. Find the letter that was meant

- Work with the letter's position in the alphabet, `0` to `25`: add one and wrap round with `% 26`.
- The lower- and upper-case cases are the same calculation from a different first letter.

## 5. Repair a text

- `map` on a string applies a character function to every character.
