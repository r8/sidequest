# Introduction

Assigning a heap value moves it; to get a second, independent value, call `clone`, from the `std.clone.Clone`
trait:

```inko
let a = [1, 2, 3]
let b = a.clone

b.push(4) # a is still [1, 2, 3]
```

Collections implement `Clone` when their contents do. Implement it for your own types by building a new value from
cloned fields; for a `copy` type, `clone` can return `self`.
