# About

A table is Janet's mutable hash map.
It is written `@{…}` with keys and values alternating, or built with `(table k1 v1 k2 v2 …)` or `@{}` and `put`.

## Reading

- `(get t k)` returns the value or `nil`; `(get t k default)` returns `default` instead of `nil`.
- `(t k)` is the same lookup as `(get t k)`, without the default.
- `(in t k)` is like `get` on a table; on arrays and tuples it raises an error for a bad index, which is why it exists.
- `(has-key? t k)` and `(has-value? t v)` test membership; `(length t)` counts the entries.
- `(get-in t [k1 k2 …])` looks up a path through nested tables and structs, with an optional default.

## Writing

- `(put t k v)` adds or replaces and returns `t`.
- `(update t k f & args)` stores `(f old-value ;args)` and returns `t`; when the key is missing, `f` receives `nil`, so `(update t :n inc)` on a missing `:n` is an error. Write `(update t :n (fn [x] (+ (or x 0) 1)))` or use `put` with a `get` default.
- `(put-in t [k1 k2] v)` and `(update-in t [k1 k2] f)` work on nested tables, creating the missing levels as tables.
- `(merge-into t & colls)` copies the entries of the other tables and structs into `t`.
- Putting `nil` removes a key, and a table never holds a `nil` value; there is no separate "delete" function.

## Iterating

- `(eachp [k v] t …)` binds each key and value; `(eachk k t …)` binds each key.
- `(keys t)`, `(values t)` and `(pairs t)` return new arrays of the keys, values and `[k v]` tuples.
- Order is unspecified: it depends on the hash of each key and on the history of the table. Sort the keys (`(sorted (keys t))`) when you need a stable order.

## Building tables from other data

- `(frequencies xs)` counts how often each value appears.
- `(zipcoll ks vs)` pairs up a sequence of keys with a sequence of values.
- `(group-by f xs)` collects the elements under the key `(f x)`.
- `(merge & colls)` returns a new table of all the entries, the later collection winning on a shared key.

## Equality and copying

Tables are compared by identity: `(= @{:a 1} @{:a 1})` is `false`, because they are two different tables.
`deep=` compares contents.
`table/clone` makes a shallow copy, and `table/to-struct` an immutable struct with the same entries.

## Prototypes

Every table can have a _prototype_, another table that `get` falls back to for a missing key.
That is how Janet does object-oriented programming, and a later lesson covers it.
