# Hints

## General

- The [syntax documentation](https://mlochbaum.github.io/BQN/doc/syntax.html) shows how characters and strings
  are written.
- The [arithmetic documentation](https://mlochbaum.github.io/BQN/doc/arithmetic.html) explains which
  arithmetic works on characters.

## 1. Greet the attendee

- `∾` joins two strings.

## 2. Put the full name together

- A space is the character `' '`, or the string `" "`.

## 3. Print the speakers' names in capitals

- Find which characters are small letters with two comparisons.
- A capital letter is 32 code points before its small letter, and a boolean can multiply 32.

## 4. Assign the tables

- A character plus a number is a character.
- Arithmetic pervades, so the same code works for a list of numbers.

## 5. Print a nickname

- A double-quote character is written `'"'`.
