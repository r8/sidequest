# Hints

## General

- [Memory blocks](https://gforth.org/manual/Memory-Blocks.html) in the Gforth manual describes `move`.
- [Dictionary allocation](https://gforth.org/manual/Dictionary-allocation.html) covers `create` and `allot` for reserving a buffer.
- Each of the four words needs its own buffer, so a few general words that work on _any_ buffer, given its address, save writing the same code four times.

## 1. Make it loud

- Walk the text a character at a time and append each one, upper-cased, to the buffer.
- Only letters from `a` to `z` change.

## 2. Frame it

- Append three pieces: the opening, the text and the closing.

## 3. Say it again

- Append the text `n` times, and a space before every copy except the first.

## 4. Space it out

- This is like Task 3 with single characters: a space before every character except the first.
- Remember the 80-character limit applies to a single character too.
