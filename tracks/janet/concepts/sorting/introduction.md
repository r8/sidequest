# Introduction

Janet's core library sorts with four functions:

- `(sort xs)` sorts an array (or buffer) in place and returns it; it refuses a tuple.
- `(sorted xs)` returns a new sorted array and leaves `xs`, which may be any indexed collection, unchanged.
- `(sort-by f xs)` and `(sorted-by f xs)` do the same, ordering the elements by the results of the key function `f`.

By default values are ordered by `<`, which works on numbers, strings (byte by byte, so uppercase before lowercase), keywords, and tuples (element by element).
`sort` and `sorted` take an optional comparator, a function of two values that returns true when the first comes first:

```janet
(sorted [42 17 30] >)                     # => @[42 30 17]
(sorted-by |($ :price) [{:price 3} {:price 1}])  # => @[{:price 1} {:price 3}]
```

The sort is not stable, so break ties explicitly — in the comparator, or with a key that returns a tuple such as `[score name]`.
