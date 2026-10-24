# Hints

## General

- The manual's [types][types] page covers fields, static and instance methods, and `fn mut`.
- Two fields are enough: one for the name and one for the readings.

## 1. Set up a station

- `new` creates the instance with `Station(…)`, giving every field a value; an empty array works for the readings.
- `name` returns the field.

## 2. Record readings

- Adding a reading changes the station, so `record` must be an `fn mut` method.

## 3. Get the latest reading

- Arrays have a method that returns their last value as an option.

## 4. Work out the average

- Sum the readings in a loop, or with `reduce`, and divide by the count converted to a `Float`. Check for no
  readings first.

## 5. Compare two stations

- The other station is a `ref Station`: you can call its `fn` methods, such as `average`.

## 6. Rename a station

- Assigning a field needs both a `let mut` field and an `fn mut` method.

[types]: https://docs.inko-lang.org/manual/latest/getting-started/types/
