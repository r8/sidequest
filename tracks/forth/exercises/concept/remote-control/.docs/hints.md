# Hints

## General

- [Execution tokens](https://gforth.org/manual/Execution-Tokens-Tutorial.html) in the Gforth tutorial, and the [reference](https://gforth.org/manual/Execution-token.html).
- Inside a definition, `[']` gives you a word's xt; `execute` runs one.

## 1. Press a button twice

- You need the xt for both runs, so keep a copy of it where the first run will not use it up.

## 2. Find a button's action

- Store the four xts in an array, in button order; finding one is then like finding any cell of an array.

## 3. Press a button

- Find the button's xt, then run it.

## 4. Replay a sequence

- Loop over the sequence's cells, pressing each button on the volume that the loop keeps on the stack.

## 5. Adjust every room

- Loop over the array's cells; for each, fetch, run the xt, and store the result back.
- Keep the xt on the stack beneath the loop's work, and drop it at the end.
