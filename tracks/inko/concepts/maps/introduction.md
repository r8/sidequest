# Introduction

`Map[K, V]` (from `std.map`, available without an import) stores values under keys. Create one with `Map.new`
and fill it with `set`; `get` returns the value or an error, so pair it with `or`:

```inko
let stock = Map.new

stock.set('tomato', 2)
stock.set('tomato', stock.get('tomato').or(0) + 1)
stock.get('tomato').or(0) # => 3
```

`contains?`, `remove`, `size`, `keys` and `values` do what their names say. Maps iterate in insertion order, and
`iter` yields `(key, value)` tuples: `for (name, count) in stock.iter { … }`.
