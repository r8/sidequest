# Introduction

A struct is an immutable map from keys to values, written `{key value key value …}`.
It is read exactly like a table — `get` with an optional default, calling the struct with a key, `has-key?`, `length`, `keys`, `values`, `eachp` — but it cannot be changed: `put` on a struct is an error.

```janet
(def origins {:saffron "Iran" :paprika "Hungary"})

(get origins :saffron)            # => "Iran"
(get origins :salt "unknown")     # => "unknown"
(origins :paprika)                # => "Hungary"
```

To get a changed struct, build a new one: `merge` combines tables and structs into a new table, and `struct` or `table/to-struct` makes a struct.
Structs, like tables, have no order and cannot hold `nil` values.
