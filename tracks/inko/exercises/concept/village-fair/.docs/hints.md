# Hints

## General

- The manual's [modules][modules] and [visibility][visibility] pages explain module names, `import` and `pub`.
- `src/village_fair.inko` already imports `Stall` from `village_fair.stalls`.

## 1. Charge for a pitch

- `POWER_FEE` is private, but `fee` is in the same module, so it can use it.

## 2. Add up the fees

- `fee` is a public method of `Stall`, so the `village_fair` module can call it. An iterator chain or a loop both
  work.

## 3. Measure the field

- A row of `n` stalls has `n - 1` gaps.

## 4. Print the programme

- `with_index` numbers the stalls from zero; `String.join` puts the entries together.

[modules]: https://docs.inko-lang.org/manual/latest/getting-started/modules/
[visibility]: https://docs.inko-lang.org/manual/latest/getting-started/visibility/
