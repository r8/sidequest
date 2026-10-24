# Introduction

Janet has two kinds of ordered list, and they come as a pair: the _tuple_, which is immutable, and the _array_, which is mutable.
Both hold any values, of any mix of types, indexed from 0.

## Writing them

```janet
[1 2 3]               # a tuple
(tuple 1 2 3)         # the same tuple
@[1 2 3]              # an array
(array 1 2 3)         # the same array
[]                    # the empty tuple
@[]                   # a new, empty array
```

The `@` prefix is Janet's mark for "the mutable version": you will meet it again on tables and buffers.

Why square brackets for tuples?
Parentheses are a tuple too, but an unquoted `(1 2 3)` is a _call_ — Janet would try to call `1` as a function.
Square brackets make a tuple that is just data.

## Reading

`length` counts the elements, and `get` reads one by index, returning `nil` (or a default you give it) when the index is out of range:

```janet
(def stops ["Ashby" "Bexley" "Crane"])

(length stops)          # => 3
(get stops 0)           # => "Ashby"
(get stops 7)           # => nil
(get stops 7 "none")    # => "none"
(first stops)           # => "Ashby"
(last stops)            # => "Crane"
```

`in` does the same as `get` but raises an error for an index out of range, and a tuple or array can also be called with an index, `(stops 1)`, which behaves like `in`.

## Changing an array

Arrays can grow, shrink and change in place.
These functions modify the array they are given:

```janet
(def queue @["Ashby"])

(array/push queue "Bexley")       # => @["Ashby" "Bexley"], added at the end
(array/pop queue)                 # => "Bexley", removed from the end
(array/insert queue 0 "Zenith")   # => @["Zenith" "Ashby"], added at index 0
(array/remove queue 0)            # => @["Ashby"], index 0 removed
(put queue 0 "Moor")              # => @["Moor"], index 0 replaced
```

`array/push`, `array/insert`, `array/remove` and `put` return the array itself, so the result can be used straight away.
`array/pop` returns the element it removed, or `nil` for an empty array, and `array/peek` returns the last element without removing it.
`array/insert` accepts any index from 0 up to the length, where inserting at the length is the same as pushing.

Tuples have none of these: `(array/push [1 2] 3)` is an error.
An "updated" tuple is always a new tuple.

## Splicing

Inside a tuple, array or call, `;` before an expression _splices_ its elements in, as though they had been written out one by one:

```janet
(def middle [2 3])
[1 ;middle 4]          # => (1 2 3 4)
@[;middle]             # => @[2 3], a new array with the same elements
(tuple ;@[1 2])        # => (1 2), a tuple with the array's elements
(+ ;middle)            # => 5, the same as (+ 2 3)
```

## Slicing and joining

`slice` returns part of a tuple or array as a new tuple, from a start index up to (not including) an end index, and `array/slice` does the same but returns an array.
`array/concat` appends the elements of other lists to an array, modifying it.

```janet
(slice [:a :b :c :d] 1 3)         # => (:b :c)
(array/slice @[:a :b :c :d] 2)    # => @[:c :d]
(array/concat @[1] [2 3] @[4])    # => @[1 2 3 4]
```

## Equality

Two tuples with equal elements are equal: `(= [1 2] [1 2])` is `true`.
Two arrays are only `=` when they are the very same array, because an array's contents can change at any moment: `(= @[1 2] @[1 2])` is `false`.
A later lesson goes into this; for now, compare tuples, not arrays.

## Pitfalls

- An array passed to a function is not copied: when the function pushes onto it, the caller's array changes too.
- `(1 2 3)` without a quote is a call. Use `[1 2 3]` for a tuple of data.
- `get` with an index out of range returns `nil` silently; `in` raises an error.
