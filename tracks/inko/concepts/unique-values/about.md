# About

## recover

`recover expr` or `recover { … }` evaluates its body with restricted access to the variables it captures:

| Captured variable | Inside `recover` |
| --- | --- |
| `T` (owned) | `uni mut T` |
| `uni T` | `uni T` |
| `mut T` | `uni mut T` |
| `ref T` | `uni ref T` |

`uni ref` and `uni mut` borrows can only be used as method call receivers, for methods the compiler considers safe.
The result of the body is turned from `T` into `uni T`, or from `uni T` into `T`. Returning a captured `uni T`
variable moves it.

Recover inference: in a method or closure returning `uni T`, a returned expression that isn't a `recover`, `loop` or
`match` is recovered automatically. Results assembled from several statements need an explicit `recover { … }`.

## Calling methods on unique values

A method can be called on a `uni T` receiver when every argument and the return value are sendable, with these
relaxations:

- an immutable (`fn`) method may also take `ref` arguments;
- a mutating method may take `ref` or sendable arguments when the type can't store borrows (none of its fields, or
  their fields, are borrows);
- a method returning an owned non-unique value is allowed when its arguments are immutable or sendable and the value
  contains no borrows;
- any method may be called when its result isn't used.

Methods returning borrows of heap values (`iter`, or `get` and `first` on an array of arrays) are never available
on unique receivers; borrows of value types are just copies, so `get` on a `uni Array[Int]` works.

## Unique values and generics

A `uni T` can be assigned to a type parameter, unless the parameter requires `mut`, since generic code could then
store non-sendable values inside it.

## Sendable values

A value is sendable when it is a value type (`Int`, `Float`, `Bool`, `Nil`, `String`, `copy` and `ref` types, and
processes) or a `uni T`. Async methods (process messages) only take sendable arguments, and process fields must be
given sendable values when the process is spawned.

## Relation to Pony

Inko's unique values correspond to Pony's isolated (`iso`) references; the manual describes them as a box whose
contents may refer to each other but to nothing outside the box.
