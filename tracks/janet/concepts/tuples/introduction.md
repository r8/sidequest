# Introduction

A tuple is an immutable, ordered list of values, written `[1 2 3]` or built with `(tuple 1 2 3)`.
It is read the same way as an array — `length`, `get`, `in`, `first`, `last` — but cannot be changed: an "updated" tuple is a new tuple.

Tuples are compared by value, so `(= [1 2] [1 2])` is `true`.

`;` splices a list's elements into a tuple, array or call:

```janet
[0 ;[1 2] 3]       # => (0 1 2 3)
(tuple ;@[1 2])    # => (1 2), a tuple copy of an array
```

`slice` returns part of a tuple or array as a new tuple.
