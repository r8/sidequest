# About

## The three pairs

| Mutable | Immutable | Literal | Convert |
| --- | --- | --- | --- |
| array | tuple | `@[…]` / `[…]` | `(array ;t)` / `(tuple ;a)` |
| table | struct | `@{…}` / `{…}` | `struct/to-table` / `table/to-struct` |
| buffer | string | `@"…"` / `"…"` | `buffer` / `string` |

Keywords, symbols, numbers, booleans and `nil` are immutable values too.
Functions that read collections accept either member of a pair; functions that change them (`put`, `array/push`, `buffer/push`, `update`) accept only the mutable one and raise an error otherwise.

## Equality

- `=` on immutable values compares content, recursively: `(= {:a [1 2]} {:a [1 2]})` is `true`.
- `=` on mutable values compares identity. A tuple holding an array compares that array by identity: `(= [1 @[2]] [1 @[2]])` is `false`.
- `deep=` compares contents recursively regardless of mutability, but kinds must match at every level: an array is never `deep=` a tuple.

Immutable values are also hashed by content, so they work as table keys: `(get @{[1 2] :here} [1 2])` finds the entry.
A mutable key is found only by the same object.

## Aliasing and copies

Collections are passed by reference.
That lets a function such as `array/push` change its caller's array, and lets two parts of a program unknowingly change each other's data.
When ownership matters, copy:

- shallow: `array/slice`, `(array ;xs)`, `table/clone`, `(merge t)`, `buffer`;
- deep and immutable: `freeze`;
- deep and mutable: `thaw` (which turns strings into buffers too, keywords and numbers stay as they are).

## Immutable updates

Immutable values are never changed, only replaced:

```janet
[;tags "roman"]                     # a tuple with one more element
(tuple/slice tags 1)                # a tuple without the first one
(struct ;(kvs piece) :room 5)       # a struct with :room replaced (the later key wins)
(table/to-struct (merge piece {:room 5}))  # the same, through a table
```

Copying a large collection for every small change costs time; build with a mutable collection and `freeze` once at the end when that matters.

## Choosing

Prefer immutable values for data that is passed around, returned, compared or used as keys: they make equality meaningful and aliasing harmless.
Use mutable ones for building and for state that is changed in place, such as an accumulator in a loop or a cache.
