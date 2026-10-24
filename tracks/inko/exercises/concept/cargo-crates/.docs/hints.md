# Hints

## General

- The manual's [generics][generics] page covers generic types, generic methods and requirements.

## 1. Set up a crate

- Two fields are enough: an `Array[T]` for the items and an `Int` for the capacity.

## 2. Load the crate

- `throw item` returns the item as the error. Check `full?` first.

## 3. Unload the crate

- Arrays already take values off the end and return an `Option`.

## 4. Look for an item

- This method is in an `impl Crate if T: Equal` block, so you can compare items; arrays can do the searching.

## 5. Write the manifest

- `String.join` joins the values of an iterator whose values implement `ToString`.

## 6. Count cargo

- `T: Equal` lets you compare items with `==`. An iterator chain or a loop both work.

[generics]: https://docs.inko-lang.org/manual/latest/getting-started/generics/
