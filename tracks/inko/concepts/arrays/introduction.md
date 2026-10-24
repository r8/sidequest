# Introduction

An `Array[T]` is a growable, ordered list of values of one type, written `[10, 20, 30]`. Indexes start at zero.
There is no indexing syntax: `get(index)` returns the value or an out-of-bounds error, and `or(default)` or
`or_panic` unwraps it:

```inko
let names = ['Ada', 'Grace']

names.get(1).or('nobody') # => 'Grace'
names.size                # => 2
names.contains?('Ada')    # => true
```

Arrays change in place with `push`, `pop`, `insert`, `set`, `remove_at`, `sort` and `reverse`. A method that only
reads an array takes `ref Array[T]`; one that changes it takes `mut Array[T]`.
