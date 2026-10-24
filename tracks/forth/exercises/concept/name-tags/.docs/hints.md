# Hints

## General

- [String words](https://gforth.org/manual/String-words.html) and [Memory blocks](https://gforth.org/manual/Memory-Blocks.html) in the Gforth manual list `compare`, `/string` and `-trailing`.
- [Characters and strings](https://gforth.org/manual/Characters-and-Strings-Tutorial.html) in the Gforth tutorial.

## 1. Find the initial

- The first character is at the address itself.

## 2. Count a letter

- Start a count below the string, then walk the string with `bounds ?do`.
- The character to look for has to stay reachable on the stack throughout the loop.

## 3. Spot a duplicate registration

- `compare` does the work, but its result for equal strings is not true.

## 4. Trim the spaces

- One word removes the trailing spaces for you.
- For the leading ones, keep dropping the first character while there is one and it is a space; check the length before you look at the character.

## 5. Take the first name

- Walk the string looking for a space; when you find it, the length you want is the distance from the start.
- `leave` ends a counted loop early.

## 6. Take the surname

- The surname starts one character after the end of the first name, so Task 5 can help, but make sure you never drop more characters than the name has.
