# About

`Map[K, V]` is a hash map that preserves insertion order. Keys must implement `Equal` and `Hash` (`String`, `Int`,
`Bool`, tuples and arrays of those, and your own types once they implement both traits).

## Methods

| Method | Returns |
| --- | --- |
| `Map.new`, `Map.with_capacity(n)` | an empty map |
| `set(key, value)` | the previous value, as an `Option[V]` |
| `get(key)` | `Result[ref V, MissingKey[K]]` |
| `get_mut(key)` | `Result[mut V, MissingKey[K]]` |
| `remove(key)` | `Result[V, MissingKey[K]]` |
| `contains?(key)` | `Bool` |
| `size`, `empty?` | `Int`, `Bool` |
| `iter`, `iter_mut`, `into_iter` | `(ref K, ref V)`, `(ref K, mut V)`, `(K, V)` tuples |
| `keys`, `values`, `values_mut` | iterators over one side |
| `merge(other)` | moves every entry of `other` in |
| `clear` | removes everything |

## Changing values in place

When the values are themselves collections, change them through `get_mut` instead of reading and setting:

```inko
let groups: Map[String, Array[String]] = Map.new

groups.set('fruit', [])
groups.get_mut('fruit').or_panic.push('apple')
```

`try_set(key, value)` inserts only when the key is missing, returning a mutable borrow of the stored value either
way (wrapped in `Ok` when it inserted, and in an `Error` with the rejected key and value otherwise).

## Equality, hashing, formatting

Maps are equal when they have the same keys mapped to equal values, regardless of order. `Map` implements `Format`
(so test failures print it as `{"key": value}`), `Hash` and `Clone` when its keys and values do.

## Ownership

`set` takes ownership of the key and the value. `get` lends the stored value; to keep a copy of a non-value-type
value, `clone` it. `into_iter` moves all entries out and consumes the map.
