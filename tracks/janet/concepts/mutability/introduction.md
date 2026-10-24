# Introduction

Janet's collections come in pairs: arrays and tuples, tables and structs, buffers and strings.
The first of each pair is mutable and written with `@` (`@[1 2]`, `@{:a 1}`, `@"hi"`); the second is immutable.

`=` compares immutable values by content and mutable ones by identity:

```janet
(= [1 2] [1 2])          # => true
(= @[1 2] @[1 2])        # => false, two different arrays
(= [1 2] @[1 2])         # => false, never equal across the pair
(deep= @[1 2] @[1 2])    # => true, contents compared all the way down
```

Binding or passing a mutable collection does not copy it, so every name for it sees every change.
`array/slice`, `table/clone` and `buffer` make shallow copies; `freeze` makes a deeply immutable copy and `thaw` a deeply mutable one.

An immutable value is "changed" by building a new one: `[;tags "new"]`, or `(struct ;(kvs record) :key new-value)`.
