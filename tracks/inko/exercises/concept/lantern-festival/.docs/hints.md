# Hints

## General

- The manual's [destructors][destructors] page covers the `Drop` trait; [memory management][memory] explains when
  values are dropped.

## 1. Put a lantern out

- `@log` is a mutable borrow of the log, so the destructor can `push` to it.

## 2. Light the parade

- The parade needs the log (as a `mut Array[String]`, like the lantern) and an array that owns its lanterns.
- `light` creates the lantern with the parade's own log and moves it into the array.

## 3. End the parade

- The destructor runs before the fields are dropped, so it only has to write its own line: the lanterns go out
  afterwards, when the array is dropped.

## 4. Let a child keep a lantern

- Find the lantern's index, then `remove_at` it: that moves it out of the array instead of dropping it.

## 5. Snuff a lantern

- `snuff` owns its argument. `std.drop.drop` drops a value right away; letting the argument go out of scope works
  too.

[destructors]: https://docs.inko-lang.org/manual/latest/getting-started/destructors/
[memory]: https://docs.inko-lang.org/manual/latest/getting-started/memory-management/
