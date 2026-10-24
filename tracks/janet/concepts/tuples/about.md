# About

## Tuples are values

A tuple (type `:tuple`) is an immutable sequence.
Because it can never change, a tuple can be shared freely, compared by contents (`=` is structural for tuples), used as a table key, and returned from a function without anyone worrying that the caller will modify it.
This makes tuples the default for fixed-size records such as a coordinate `[x y]` or a pair `[:ok value]`, and for lists that are built once and then only read.

## Brackets and parentheses

A tuple written with parentheses, `(f a b)`, is how Janet source code represents a call, and evaluating it calls `f`.
A tuple written with square brackets, `[a b]`, evaluates its elements and produces a tuple of the results.
Both are tuples once read; `tuple/type` tells them apart (`:parens` or `:brackets`), which matters mostly to macros.
`'(1 2 3)`, quoted, is a tuple of data too, and the quoting lesson explains it.

## Building and taking apart

- `(tuple a b c)` and `[a b c]` build one; `(tuple ;xs)` and `(tuple/slice xs)` copy any list into a tuple.
- `slice` and `tuple/slice` take part of a tuple or array as a tuple, with negative indexes counting from the end.
- `;` splices: `[;a ;b]` concatenates two lists into a tuple, `(+ ;xs)` passes a list's elements as arguments.
- Destructuring, `(def [x y] point)`, takes a tuple apart by position; it has its own lesson.

## Comparing

`=` compares tuples element by element.
`<`, `>` and `compare` order them lexicographically, first element first, so `(< [1 2] [1 3])` is `true` — handy for sorting by several keys.

## Arrays or tuples?

Use a tuple when the list is fixed once made, an array when it grows or changes.
Most `array/` functions refuse a tuple; the general functions (`length`, `get`, `map`, `filter`, `each`) take either, and many of them return a new array or tuple rather than modifying their argument.
