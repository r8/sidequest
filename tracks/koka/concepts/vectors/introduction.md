# Introduction

A `vector<a>` stores its elements side by side, so any of them can be read by its index (from `0`) without
walking a list. Vectors are made by functions: `vector(n, x)` repeats `x`, `vector-init(n, fn(i) …)` computes each
element from its index, and `xs.vector` converts a list; `.list` converts back, which is also how to print or
compare one.

```koka
val squares = vector-init(5, fn(i) i * i)
squares[2]       // 4, and throws "index out of bounds" past the end (the exn effect)
squares.at(9)    // Nothing: at returns a maybe
```

To replace an element, copy the vector into a `var` and assign: `var w := v; w[i] := x`. The original is not
changed; when it is not shared, Koka updates it in place instead of copying. Koka 3.2.9 does not catch negative
indices, so check them yourself.
