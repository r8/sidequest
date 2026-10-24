# Introduction

Every Janet collection comes in two versions, one you can change and one you cannot:

| Mutable | Immutable | Example |
| --- | --- | --- |
| array | tuple | `@[1 2]` and `[1 2]` |
| table | struct | `@{:a 1}` and `{:a 1}` |
| buffer | string | `@"hi"` and `"hi"` |

The `@` in front of a literal always means "the mutable one".
Choosing between them is not only about whether you call `put` or `array/push`: it decides what equality means, and who sees a change.

## Values and identities

An immutable value is just its contents.
Two tuples with the same elements are the same tuple as far as Janet is concerned, so `=` compares immutable collections by content:

```janet
(= [1 2] [1 2])              # => true
(= {:a 1} {:a 1})            # => true
(= "bronze" "bronze")        # => true
```

A mutable collection is an _object_ with an identity: it may hold the same contents as another one today and different contents tomorrow.
`=` on mutable collections asks "is this the same object?":

```janet
(= @[1 2] @[1 2])            # => false, two different arrays
(def a @[1 2])
(= a a)                      # => true
```

A mutable and an immutable collection are never `=`, whatever they hold: `(= [1 2] @[1 2])` is `false`.

## Comparing contents with `deep=`

`deep=` compares contents all the way down, mutable or not:

```janet
(deep= @[1 2] @[1 2])                        # => true
(deep= @{:tags @["iron"]} @{:tags @["iron"]}) # => true
```

It still requires the same kinds at every level: an array is not `deep=` a tuple, nor a table a struct.

## Aliasing

Binding a mutable collection to a second name, or passing it to a function, does not copy it.
Both names refer to the same object, so a change through one is seen through the other:

```janet
(def shelf @["vase"])
(def same-shelf shelf)
(array/push same-shelf "bowl")
shelf # => @["vase" "bowl"]
```

That is often exactly what you want — it is how a function like `array/push` can change your array — but when two parts of a program should not affect each other, one of them needs a copy.

## Copying

Each mutable type has a way to make a fresh, independent copy of its top level:

```janet
(array/slice @[1 2 3])     # => a new array @[1 2 3]
(table/clone @{:a 1})      # => a new table @{:a 1}
(buffer "text")            # => a new buffer @"text"
```

These are _shallow_ copies: a mutable collection _inside_ the copy is still shared with the original.

## Freezing and thawing

`freeze` returns a deeply immutable copy: arrays become tuples, tables structs and buffers strings, at every level.
`thaw` does the opposite, returning a deeply mutable copy.
Neither changes its argument.

```janet
(freeze @{:name @"Urn" :tags @["clay"]})  # => {:name "Urn" :tags ("clay")}
(thaw {:name "Urn" :tags ["clay"]})       # => @{:name @"Urn" :tags @[@"clay"]}
```

A frozen value can be compared with `=`, used as a key in a table, and handed to any code without fear that it will be changed.

## "Changing" an immutable value

You cannot change a struct or a tuple, but you can make a new one that differs a little.
Splicing builds a tuple with an element added, and `struct` with the old key–value pairs followed by a new one builds a struct with a key replaced, since a later key wins:

```janet
(def tags ["clay" "urn"])
[;tags "roman"]                    # => ("clay" "urn" "roman")

(def piece {:name "Urn" :room 4})
(struct ;(kvs piece) :room 5)      # => {:name "Urn" :room 5}
piece                              # => {:name "Urn" :room 4}, unchanged
```

`kvs` returns the keys and values of a struct or table as one flat array, ready to splice.

## Pitfalls

- An immutable collection can hold mutable ones: the tuple `[1 @[2]]` cannot change, but the array inside it can. Use `freeze` when nothing at all may change.
- `(= @{} @{})` is `false`. When equality "does not work", check whether you are comparing mutable collections.
- A shallow copy shares the nested collections with the original.
