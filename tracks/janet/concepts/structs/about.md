# About

A struct is the immutable counterpart of a table, as a tuple is of an array and a string of a buffer.
It is written `{…}` or built with `(struct k1 v1 k2 v2 …)`.

## Reading

Every read operation that works on a table works on a struct: `get` (with a default), calling the struct as a function, `in`, `get-in`, `has-key?`, `length`, `keys`, `values`, `pairs`, `eachp` and `eachk`.
A struct, like a table, has no defined order and drops `nil` values: `{:a nil :b 2}` is `{:b 2}`.

## Not writing

`put`, `update` and the other mutating functions raise an error on a struct.
A "changed" struct is a new one:

```janet
(def base {:size :small :milk :oat})

(merge base {:size :large})                  # => @{:size :large :milk :oat}, a table
(table/to-struct (merge base {:size :large})) # => {:size :large :milk :oat}
(struct/to-table base)                        # => @{:size :small :milk :oat}
```

## Equality

Structs are values: two structs with the same keys and values are `=`, and a struct can be a key in another table or struct.
That makes them the natural choice for records that are passed around and compared, such as `{:x 3 :y 4}`.
Tables are compared by identity instead, so `(= @{:a 1} @{:a 1})` is `false`.

## When to use which

Use a struct for fixed data — constants, lookup tables, records you return — and a table for anything you build up or change.
Both are hash maps underneath, so lookups are equally fast.

## Prototypes

A struct can have a prototype too, made with `struct/with-proto`; `struct/getproto` returns it.
A later lesson covers prototypes on tables, where they are more common.
