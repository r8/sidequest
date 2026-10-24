# Hints

## General

- [`POSTPONE`](https://gforth.org/manual/POSTPONE-Tutorial.html) and [macros](https://gforth.org/manual/Advanced-macros-Tutorial.html) in the Gforth tutorial.
- [Macros](https://gforth.org/manual/Macros.html) in the Gforth manual.
- `see` shows what a macro compiled into a definition.

## 1. Square without a call

- Postpone each word that squaring needs.

## 2. Act unless

- `unless` is `if` with the flag inverted first; postpone both.

## 3. Do it twice

- `'` inside an immediate word reads the next word of the source being compiled.
- `compile,` compiles an execution token; you need its argument twice.

## 4. Number the steps

- Update the variable first, then compile what it holds.
- `literal` is immediate, so it needs to be postponed to compile the number into the definition that uses `step`.

## 5. Repeat a move

- A counted loop from 0 to `n` does what `times` describes; `?do` skips it when the two are equal.
- `?do` needs the start, 0, after the count: compile it as a literal.
