# About

`Array[T]` is a heap-allocated, growable array. Its values are stored in order, and it owns them: dropping the
array drops its values, in order from first to last.

## Creating

```inko
[1, 2, 3]
Array.with_capacity(100)    # empty, with room for 100 values
Array.filled(with: 0, times: 5) # => [0, 0, 0, 0, 0]
```

## Reading

| Method | Returns |
| --- | --- |
| `get(index)` | `Result[ref T, OutOfBounds]` |
| `first`, `last` | `Option[ref T]` |
| `size`, `empty?` | `Int`, `Bool` |
| `contains?(value)` | `Bool` (needs `T: Equal`) |
| `index_of(value)` | `Option[Int]` |
| `slice(start, end)` | a `Slice` view of part of the array |

`get` returns a borrow of the value, not a copy; for value types such as `Int` and `String` that makes no
difference. `get_mut` returns a mutable borrow when the values themselves need changing.

## Changing

| Method | Effect |
| --- | --- |
| `push(value)` | add to the end |
| `pop` | remove and return the last value, as an `Option` |
| `insert(index, value)` | insert, shifting later values right; panics when out of bounds |
| `set(index, value)` | replace, dropping the old value; panics when out of bounds |
| `swap(index, value)` | replace and return the old value |
| `remove_at(index)` | remove and return, as a `Result` |
| `remove_if(fn)` | remove every value for which the closure returns `true` |
| `append(other)` | move all values of another array to the end |
| `sort`, `sort_by(fn)` | sort in place (stable) |
| `reverse` | reverse in place |
| `clear` | remove everything |

## Iterating

`iter` yields borrows of the values, `iter_mut` mutable borrows, `reverse_iter` borrows from last to first, and
`into_iter` moves the values out, consuming the array. The loops and iterators lessons use them.

## Equality and printing

Arrays implement `Equal`, `Hash`, `Clone` and `Format` when their values do, so `[1, 2] == [1, 2]` and arrays can
be compared in tests.

## Patterns

`match` can match arrays of an exact size: `case [a, b] -> …`. Patterns for "two or more values" don't exist, so
match on `size` or use `first` and `last` for those.

## Ownership

Values put into an array are moved into it, and values taken out with `pop`, `remove_at` or `into_iter` are moved
out. The borrowing lesson explains what `ref` and `mut` in `ref Array[T]` and `mut Array[T]` mean exactly.
