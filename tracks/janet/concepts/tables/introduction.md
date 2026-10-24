# Introduction

A table is a mutable map from keys to values, written `@{key value key value …}`.
Keys are usually keywords, but any value except `nil` will do.

```janet
(def jars @{:salt 120 :pepper 40})

(get jars :salt)        # => 120
(get jars :saffron 0)   # => 0, the default for a missing key
(jars :pepper)          # => 40, a table can be called with a key
(has-key? jars :salt)   # => true

(put jars :thyme 15)    # adds or replaces a key; returns the table
(update jars :salt - 20) # replaces the value with (- 120 20)
(put jars :thyme nil)   # putting nil removes the key
```

`eachp` loops over the key–value pairs, `eachk` over the keys; `keys` and `values` return arrays.
Tables have no order, so never depend on the order those return.
