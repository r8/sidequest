# Introduction

Arrays and tuples hold values in order, found by their index.
Tables and structs hold values under _keys_: you ask for the value of `:salt`, not the value at position 3.
Other languages call this a dictionary, a map or a hash.

## Tables and structs

A _table_ is mutable and is written with `@{…}`; a _struct_ is immutable and is written with `{…}`.
Between the braces come keys and values, alternating:

```janet
(def jars @{:salt 120 :pepper 40})   # a table
(def sizes {:small 50 :large 200})   # a struct
```

This is the same split you have seen between arrays (`@[…]`) and tuples (`[…]`): the `@` marks the mutable one.
Any value except `nil` can be a key, but keywords are by far the most common, and strings and numbers are fine too.
A key appears at most once.

## Looking values up

`get` returns the value under a key, or `nil` when the key is missing.
A third argument is the default returned instead of `nil`:

```janet
(get jars :salt)          # => 120
(get jars :saffron)       # => nil
(get jars :saffron 0)     # => 0
```

Tables and structs can also be called like functions with the key as the argument, which reads well for a quick lookup:

```janet
(jars :pepper)            # => 40
(sizes :large)            # => 200
```

`has-key?` tells you whether a key is present at all, and `length` counts the entries:

```janet
(has-key? jars :salt)     # => true
(length sizes)            # => 2
```

## Changing a table

`put` stores a value under a key, adding the key or replacing its value, and returns the table:

```janet
(def shelf @{})
(put shelf :thyme 15)     # => @{:thyme 15}
(put shelf :thyme 30)     # => @{:thyme 30}
```

`update` replaces a value with the result of calling a function on the old one.
Extra arguments are passed to the function after the old value:

```janet
(update shelf :thyme + 5) # => @{:thyme 35}, the old 30 plus 5
```

When the key is missing, the function receives `nil`, so `(update shelf :basil + 5)` is an error: `+` cannot add `nil`.

A table never stores `nil`.
Putting `nil` under a key removes that key:

```janet
(put shelf :thyme nil)    # => @{}
```

Structs are immutable: `put` on a struct is an error.
To get a changed struct you build a new one, for example with `merge`, which combines tables and structs into a new table, later ones winning:

```janet
(merge {:a 1 :b 2} {:b 3}) # => @{:a 1 :b 3}
```

## Going through every entry

`eachp` loops over the key–value pairs, binding both, and `eachk` over the keys alone.
`keys` and `values` return arrays of them:

```janet
(eachp [spice grams] @{:salt 120 :pepper 40}
  (print spice " " grams))

(keys {:a 1 :b 2})        # => @[:a :b], in some order
```

The `[spice grams]` in `eachp` gives names to the two halves of each pair, the way `each` names each element.

## Pitfalls

- A table or struct has no order. Two runs, or two equal tables, may list their keys differently, so never rely on the order of `keys`, `values` or `eachp`.
- A missing key is not an error: `get` returns `nil` (or your default), which can hide a typo in a key. Use `has-key?` when the difference matters.
- `nil` cannot be stored. A key whose value would be `nil` simply is not there.
