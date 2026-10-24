# Introduction

An iterator (anything implementing `std.iter.Iter`) produces values one at a time through `next`. Arrays give one
with `iter`, ranges with `iter`, strings with `chars`.

Lazy methods return a new iterator: `map`, `select`, `with_index`, `zip`, `skip`, `take`. Consuming methods produce
a result: `to_array`, `count`, `reduce`, `any?`, `all?`, `find`, `last`. `Int.sum` adds up integers.

```inko
let counts = [3, 10, 0, 7]

counts.iter.select(fn (n) { n > 2 }).map(fn (n) { n * 10 }).to_array # => [30, 100, 70]
counts.iter.reduce(0, fn (sum, n) { sum + n })                      # => 20
```

An iterator is used up once consumed; call `iter` again for a fresh one.
