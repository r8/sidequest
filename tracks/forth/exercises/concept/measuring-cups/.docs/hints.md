# Hints

## General

- [User-defined defining words](https://gforth.org/manual/User_002ddefined-Defining-Words.html) in the Gforth manual explains `create … does>`.
- The [defining words tutorial](https://gforth.org/manual/Defining-Words-Tutorial.html) builds up to it step by step.

## 1. Define units

- Store the number of millilitres in the new word's data; the code after `does>` gets its address.

## 2. Count the stirs

- The data is a count that starts at 0 and changes on every use.
- `+!` adds to a cell without a separate fetch and store, but you still need the new value afterwards.

## 3. Start counting again

- `>body` turns the counter's execution token into the address of its count.

## 4. Label the spice shelves

- Reserve the cells after `create`, and clear them before or after reserving them: `here` is where they start.
- The code after `does>` gets the jar number below the shelf's address.
