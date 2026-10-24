# Hints

## General

- The manual's [maps][maps] page introduces maps, and the [Map][map] documentation lists every method.

## 1. Build the catalogue from a donation

- Start with `Map.new`, loop over the labels, and set each one to its old count (or zero) plus one.

## 2. Look up a variety

- `get` returns an error for a missing key; `or` turns that into a default.

## 3. Add returned packets

- Read the current count with a default, then `set` the new one.

## 4. Retire a variety

- `remove` returns the removed value, or an error when there was none.

## 5. List the varieties that are running low

- `iter` yields `(name, packets)` pairs in the order the names were added.

[maps]: https://docs.inko-lang.org/manual/latest/getting-started/maps/
[map]: https://docs.inko-lang.org/std/latest/module/std/map/Map/
