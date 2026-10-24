# Hints

## General

- [The input stream](https://gforth.org/manual/The-Input-Stream.html) in the Gforth manual covers `parse-name`, `parse`, `source` and `>in`.
- [Input sources](https://gforth.org/manual/Input-Sources.html) describes `evaluate`.

## 1. Count the letters

- One word reads the next space-delimited word; you need only its length.

## 2. Read up to the full stop

- The other parsing word takes the delimiter character.

## 3. Peek at the next word

- Save `>in` before parsing and put it back afterwards; the return stack is a good place to keep it meanwhile.

## 4. Replay a note

- The evaluated text must find the stack without the string on top, but the loop needs the string again on the next round.

## 5. Define an abbreviation

- `create` reads the name; the rest of the line is `source` from `>in` on, and `>in` has to be moved to its end.
- Store the length and the characters in the new word's data; `count` turns that back into a string.
