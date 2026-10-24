# Hints

## General

- The manual's [types][types] page has a section on enums, and [pattern matching][patterns] shows how to match
  their cases.
- In a `case`, write the case name alone (`Healing(s)`); to create a value, write the type too
  (`Potion.Healing(s)`).

## 1. Measure the bottles

- Match on `self`, binding the litres of a barrel to a name.

## 2. Price a potion

- One `case` per kind of potion; no wildcard is needed when all three are listed.

## 3. Label a bottle

- Interpolate the bound value into the label.

## 4. Brew it stronger

- Each case returns a new `Potion` value.

## 5. Take an order

- Match on the kind, a `String`, so a wildcard case returns `Option.None`.

[types]: https://docs.inko-lang.org/manual/latest/getting-started/types/
[patterns]: https://docs.inko-lang.org/manual/latest/getting-started/pattern-matching/
