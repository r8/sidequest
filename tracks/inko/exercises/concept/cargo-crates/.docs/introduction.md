# Introduction

You've been using generic types since the arrays lesson: `Array[Int]` and `Array[String]` are the same `Array`
type holding different things, and `Option[T]` and `Map[K, V]` work for any `T`, `K` and `V`. _Generics_ let you
write such types and methods yourself.

## Generic types

A type becomes generic by naming one or more _type parameters_ in square brackets after its name. Inside the type,
the parameter stands for whatever type the user picks:

```inko
type pub Box[T] {
  let @value: T

  fn pub static new(value: T) -> Box[T] {
    Box(value: value)
  }

  fn pub value -> ref T {
    @value
  }
}

Box.new(42)      # a Box[Int]
Box.new('hello') # a Box[String]
```

Inko usually works out the type arguments from the values you pass. When it can't, for example when creating an
empty collection, name them in the variable's type: `let box: Box[Int] = …`.

Several parameters are separated by commas:

```inko
type pub Pair[A, B] {
  let @first: A
  let @second: B
}
```

## What you can do with a T

Inside `Box`, the compiler knows nothing about `T`: it might be an `Int`, a `String`, or something that can't be
compared or printed. So all you can do with a plain `T` is store it, move it, borrow it and give it back. That's
enough for containers: pushing a `T` into an `Array[T]`, popping it out as an `Option[T]`, returning it in a
`Result[Nil, T]`.

A method that _borrows_ a generic value says so in its type, as with any other value: `ref T` in a return type
lends the stored value without giving it away.

## Requirements

To do more, a type parameter can _require_ traits, written after a colon. Then only types implementing those
traits can be used, and in return their methods are available:

```inko
import std.cmp (Equal)

fn pub all_same?[T: Equal](values: ref Array[T]) -> Bool {
  let Some(first) = values.first else return true

  values.iter.all?(fn (value) { value == first })
}

all_same?([1, 1, 1])  # => true
all_same?(['a', 'b']) # => false
```

That is also a _generic method_: the type parameter goes after the method's name. Several requirements are joined
with `+`, as in `T: Equal + ToString`.

## Conditional methods

Sometimes only _some_ methods of a generic type need a requirement. `Array.contains?` only exists for arrays whose
values implement `Equal`; an `Array[fn]` simply has no `contains?`. You can do the same by reopening the type with
`impl … if`:

```inko
import std.string (ToString)

impl Box if T: ToString {
  fn pub describe -> String {
    'a box holding ${@value}'
  }
}

Box.new(42).describe # => 'a box holding 42'
```

A `Box[Array[Int]]` can still be created, it just has no `describe` method, since arrays don't implement
`ToString`.

## Generic types with mutation

A field of type `T` is exposed as `ref T` in `fn` methods and `mut T` in `fn mut` methods, like any other field. To
call an `fn mut` method on a `T` itself, it needs the `mut` requirement (`T: mut + Counter`), which rules out
borrowed and immutable types. You won't need that here: changing a field that holds an `Array[T]` is no different
from any other array.

## Generics versus traits as types

A trait used as a type (`Array[Exhibit]`) holds values of _different_ types and decides at runtime which method to
call; each value has to be cast with `as`. A generic method (`fn show[T: Exhibit](item: ref T)`) works with any
single type, chosen at compile time, needs no casts, and accepts borrows. Prefer generics unless you need to mix
types in one collection.
