# Hints

## General

- [Interpretation and compilation semantics](https://gforth.org/manual/Interpretation-and-Compilation-Semantics-and-Immediacy-Tutorial.html) in the Gforth tutorial explains immediate words.
- [Literals](https://gforth.org/manual/Literals.html) in the Gforth manual covers `literal`, `[` and `]`.

## 1. Work out the seconds in a day

- Switch to interpreting inside the definition, multiply, and compile the result.

## 2. Print the edition

- One of the two words fetches at compile time, the other when it runs.

## 3. Count the footnotes

- `+!` adds to a variable.
- Mark the word `immediate` so that it runs during compilation.

## 4. Refuse footnotes outside a definition

- `state` tells you whether the interpreter is compiling.
