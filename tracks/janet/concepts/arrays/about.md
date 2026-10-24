# About

## Arrays are mutable

An array (type `:array`) is a growable, mutable sequence: `@[1 2 3]`, `(array 1 2 3)`, `(array/new capacity)` for an empty one with room reserved, `(array/new-filled 3 0)` for `@[0 0 0]`.
Mutation is in place and the array is passed by reference: a function that receives an array and pushes onto it changes the caller's array.
That is usually what you want for an accumulator, and a source of surprises otherwise; copy with `(array/slice a)` or `@[;a]` before handing an array to code that might change it.

## Reading

| Call | For a missing index |
| --- | --- |
| `(get a i)` | `nil` |
| `(get a i default)` | `default` |
| `(in a i)` | an error |
| `(a i)` | an error, like `in` |

`first`, `last`, `array/peek` (the last element, `nil` when empty), `length`, `empty?`, `index-of` and `has-value?` are the other common readers.
`get`, `in` and `put` do not count negative indexes from the end (`(get a -1)` is `nil`); `array/slice`, `slice` and `array/insert` do, with `-1` meaning the end of the array.

## Writing

- `array/push` appends one or more values; `array/pop` removes and returns the last one.
- `array/insert a i v…` inserts before index `i`, where `i` may equal the length (append) or be negative, counting from the end.
- `array/remove a i &opt n` removes `n` (default 1) elements starting at `i`.
- `put` replaces an element; putting at an index beyond the end extends the array, filling the gap with `nil`.
- `array/concat` appends the elements of other arrays and tuples (and single values) to the first array.
- `array/clear`, `array/fill`, `array/trim` and `reverse!` complete the set.

Every one of these except `array/pop` returns the array, so calls can be nested.

## Equality

Arrays are compared by identity: `(= @[1] @[1])` is `false`, because two arrays that are equal now may not be equal after the next `push`.
`deep=` compares contents, and the mutability lesson explains the design.

## Iterating

The loops lesson covers `each` and `for`, and the higher-order functions lesson `map`, `filter` and `reduce`, all of which take arrays and tuples alike.
