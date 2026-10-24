# Hints

## General

- [Under](https://mlochbaum.github.io/BQN/doc/under.html) explains structural and computational Under.
- [Replicate](https://mlochbaum.github.io/BQN/doc/replicate.html) and
  [Select](https://mlochbaum.github.io/BQN/doc/select.html) are the structural functions this lesson uses.

## 1. Black out marked characters

- Filter with the mask, then change what the filter picked out.
- The changed part must keep its length: replace each character, not the whole part.

## 2. Hide the phone numbers

- Build the mask from the text itself, inside a block.
- A character is a digit when it is at least `'0'` and at most `'9'`.

## 3. Capitalise names

- Select the characters at the indices, then change them.

## 4. Lower the secrecy level

- The level is the first element.
- `⌈` with two arguments is the larger of the two.

## 5. Round the budget figures

- Rounding down to hundreds is rounding down to a whole number in a world where everything is divided by 100.
