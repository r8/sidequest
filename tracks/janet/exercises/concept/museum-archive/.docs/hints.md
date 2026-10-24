# Hints

## General

- The Janet documentation on [data structures](https://janet-lang.org/docs/data_structures/index.html) describes each mutable type and its immutable counterpart.
- [Comparison operators](https://janet-lang.org/docs/comparison.html) explains `=`, `deep=` and how mutable values compare.

## 1. Compare two records

- `=` on two tables only asks whether they are the same table.

## 2. Seal a record

- One core function makes a deeply immutable copy.

## 3. Reopen a record

- One core function makes a deeply mutable copy.

## 4. Copy the visitor log

- Binding the log to a new name does not copy it.
- `array/slice` with no indices copies the whole array.

## 5. Add a note to a sealed record

- `get` with a default handles a record without notes.
- Splicing with `;` builds a new tuple from an old one; `struct` with `(kvs record)` spliced in, followed by the new `:notes`, builds the new record.
