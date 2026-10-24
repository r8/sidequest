# Hints

## General

- [Assert and Catch](https://mlochbaum.github.io/BQN/doc/assert.html) explains `!` and `⎊`.
- The [system values specification](https://mlochbaum.github.io/BQN/spec/system.html) describes
  `•CurrentError`.

## 1. Check the weight

- `msg ! cond` raises `msg` unless `cond` is `1`.
- Write one assertion per rule, in the order the rules are given.

## 2. Measure the parcel

- A destructuring header names the three sides.
- Every side must pass: combine the comparisons with `∧`.

## 3. Work out the postage

- Errors pass through the functions that call the one that failed; you don't have to do anything.

## 4. Keep the scales display running

- The right operand of `⎊` can be a plain value.

## 5. Report on a parcel

- When `Volume` succeeds, its result is not what you want; ignore it and return `"ok"`.
- In the handler, `•CurrentError @` gives the message.
