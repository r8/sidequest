# Introduction

Most types you define with `type` live on the heap and follow the ownership rules of the last two lessons: one
owner, moved on assignment, borrowed with `ref` and `mut`. Some values are better off behaving like numbers: small,
copied freely, never borrowed. Inko calls them _value types_, and you've used them all along: `Int`, `Float`,
`Bool`, `Nil` and `String` are value types. You can define your own.

## copy types

`type copy` defines a type whose values are stored on the stack and _copied_ every time they're moved:

```inko
type pub copy Point {
  let pub @x: Int
  let pub @y: Int
}

let a = Point(x: 1, y: 2)
let b = a  # a copy

a.x # fine: a is still usable
```

A `copy` type can only hold other `copy` values: `Int`, `Float`, `Bool`, `Nil` and other `copy` types. `String`
and `Array` aren't allowed, and neither are borrows. The same modifier works for enums (`type copy enum`), which is
how most enums without data are defined.

Since copies are independent, borrowing a `copy` value makes no sense, and arguments are written with the plain
type, `other: Point` rather than `ref Point`. That includes trait implementations: `fn pub ==(other: Point) -> Bool`.

## Changing a copy type

A `copy` value is immutable through borrows and `fn mut` methods don't exist for it. Fields declared `let mut` can
only be assigned through an _owned_ value, such as `self` in an `fn move` method. Since calling an `fn move`
method on a `copy` value works on a copy, the idiom is: change the fields, then return `self`:

```inko
type pub copy Point {
  let pub mut @x: Int
  let pub mut @y: Int

  fn pub move shifted(by: Int) -> Point {
    @x += by
    @y += by
    self
  }
}

let a = Point(x: 1, y: 2)
let b = a.shifted(10)

a.x # => 1, a didn't change
b.x # => 11
```

## inline types

`type inline` also stores values on the stack, but unlike `copy` they may hold anything, including strings and
arrays, and they're _moved_, not copied. Tuples, `Option` and `Result` are inline types. Use them for small
wrappers created in large numbers, where avoiding a heap allocation pays off.

## ref types

`type ref` defines a heap type with atomic reference counting: "moving" a value increments its count, and both the
old and the new reference stay usable. Its fields may only hold `copy` and `ref` values, can't be assigned, and it
can't be mutated at all. `String` is the standard library's main example. `ref` types are handy for small,
immutable, shared data such as configuration.

## Which to choose

- A regular `type` when the value is mutated in place, is large, holds many heap values, is recursive, or must be
  cast to a trait.
- `type copy` for small, immutable values made only of numbers and booleans: colours, coordinates, money in cents.
- `type inline` for small values that hold strings or other heap data.

## Cloning

A heap value can't be copied by assignment: that moves it. When you need a second, independent value, _clone_ it.
`clone` comes from the `Clone` trait in `std.clone`:

```inko
let a = [1, 2, 3]
let b = a.clone

b.push(4)
a # => [1, 2, 3]
b # => [1, 2, 3, 4]
```

`Array`, `Map`, `Option`, `Result` and tuples implement `Clone` when their contents do. For your own types,
implement it by building a new value from cloned fields:

```inko
import std.clone (Clone)

type pub Playlist {
  let @title: String
  let @songs: Array[String]
}

impl Clone for Playlist {
  fn pub clone -> Playlist {
    Playlist(title: @title, songs: @songs.clone)
  }
}
```

A `String` field doesn't need cloning: it's a value type. A field holding an array does, or both values would end up
fighting over the same array. For a `copy` type, `clone` can simply return `self`, since it's copied anyway; that
is still worth doing, because generic code such as `Array.clone` requires `Clone`.

Cloning costs time and memory, so prefer borrowing, and clone only when you really need a second copy that changes
independently.
