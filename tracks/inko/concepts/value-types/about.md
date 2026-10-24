# About

## The kinds of types

| Definition | Stored | On a move | Mutable | Fields may hold | Cast to a trait |
| --- | --- | --- | --- | --- | --- |
| `type` | heap | moved | yes | anything | yes |
| `type inline` | stack | moved | owned values only | anything except itself | no |
| `type copy` | stack | copied | owned values only | `copy` types | no |
| `type ref` | heap, atomically counted | count increased | no | `copy` and `ref` types | no |
| `type async` | its own process | reference counted | by itself | sendable values | no (can't implement traits) |

`enum` combines with `inline` and `copy` (`type copy enum Direction { … }`).

## copy types

`copy` types are the size of their fields, as if you'd passed the fields separately: a `copy` type with one `Int`
field is represented exactly like an `Int`. They can't implement `Drop`, can't be recursive, and generic `copy`
types only accept `copy` type arguments (`Box([10])` is rejected for a `type copy Box[T]`). A type parameter of
other generic code can require `copy` with `T: copy`.

Borrowing a `copy` value gives a copy, so the compiler warns about `ref` on value types and expects plain types in
signatures (`fn pub ==(other: Point)`).

## inline types

`inline` types avoid a heap allocation but may hold heap values. Borrowing one copies its stack part and increments
the borrow count of every heap value inside, so an inline type holding many heap values is costly to borrow. Field
assignments are only visible through borrows created after the assignment. `inline` types can define a destructor.

## ref types

A `type ref` value is shared by reference counting: `let b = a` makes `a` and `b` refer to the same value. Because
it is immutable and atomically counted, it can be sent between processes as is. Its destructor runs when the last
reference is dropped.

## Value types and processes

Value types are _sendable_: they can be passed to another process without `recover` (see the unique-values lesson).
Strings in particular can be sent freely.
