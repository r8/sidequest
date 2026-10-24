# Hints

## General

- The manual's [control flow][control-flow] page covers `if`, `and` and `or`.
- The [Bool][bool] type documents what you can do with booleans.

## 1. Know when to light the lamp

- The lamp's hours wrap around midnight, so the hour is either late or early: think `or`.

## 2. Know when to sound the foghorn

- Both conditions must hold. `ships_nearby` is already a `Bool`; there's no need to compare it with `true`.

## 3. Raise the right storm flag

- Use `if`, `else if` and `else`, checking the ranges in order, or return early from each one.

## 4. Know when Tomas can rest

- Reuse the methods from the earlier tasks, and negate their answers with `!`.

[control-flow]: https://docs.inko-lang.org/manual/latest/getting-started/control-flow/
[bool]: https://docs.inko-lang.org/std/latest/module/std/bool/Bool/
