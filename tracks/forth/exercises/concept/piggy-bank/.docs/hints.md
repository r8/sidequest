# Hints

## General

- [Variables](https://gforth.org/manual/Variables.html), [Constants](https://gforth.org/manual/Constants.html) and [Values](https://gforth.org/manual/Values.html) in the Gforth manual.
- Declare variables, constants and values at the top level of the file, before the words that use them.

## 1. Name the coins

- Each coin is one line: the number, then `constant` and the name.

## 2. Count the savings

- Emptying is storing a zero; the balance is a fetch.

## 3. Put money in

- One word adds a number to a variable in place.

## 4. Take money out

- First work out how much can actually be taken: the smaller of what is asked for and what is there.
- Keep a copy of that amount to leave on the stack, and subtract the other copy from the savings.

## 5. Set a goal

- `value` makes the name; `to` changes it, also from inside a definition.
