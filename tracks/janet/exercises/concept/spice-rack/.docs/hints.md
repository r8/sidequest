# Hints

## General

- The Janet documentation on [tables](https://janet-lang.org/docs/data_structures/tables.html) and [structs](https://janet-lang.org/docs/data_structures/structs.html) covers creating, reading and changing them.
- The [core API](https://janet-lang.org/api/index.html) documents `get`, `put`, `update`, `has-key?` and `eachp`.

## 1. Tell where a spice comes from

- `get` takes an optional third argument: the value to return when the key is missing.

## 2. Check how much is left

- This is the same kind of lookup as the first task, on a table instead of a struct.

## 3. Restock a spice

- `put` returns the table it changed.
- The function from task 2 already knows what a missing jar holds.

## 4. Use a spice

- Work out the grams that will be left first, then decide whether to store them or remove the key.
- Putting `nil` under a key removes it.

## 5. List what to order

- Start from an empty table, `@{}`, and add to it.
- `eachp` gives you each spice together with its grams.
