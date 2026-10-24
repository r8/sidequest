# About

## Syntax

```inko
type pub Pair[A, B] { … }                 # generic type
trait pub Container[T] { … }              # generic trait
fn pub first[T](values: ref Array[T]) …   # generic method
fn pub largest[T: Compare + Clone](…)     # requirements
impl Pair if A: ToString, B: ToString { … } # conditional methods
impl Equal for Pair if A: Equal, B: Equal { … } # conditional trait implementation
```

Explicit type arguments: `example[Int](10)`, `std.reflect.size_of[Float]`.

## Requirements

| Requirement | Meaning |
| --- | --- |
| `T: SomeTrait` | `T` implements the trait; its methods are available |
| `T: A + B` | both traits |
| `T: mut` | `T` is owned or a mutable borrow, so `fn mut` methods can be called on it |
| `T: copy` | `T` is a `copy` type (`Int`, `Float`, `Bool`, `type copy …`) |

`mut` and `copy` can't be combined. A `uni T` value (see the unique values lesson) can be used for a type parameter,
unless the parameter requires `mut`.

## Specialisation

Generic code is _specialised_: the compiler generates a version of a generic type or method for each kind of type
argument it is used with, so calls on a `T` are as fast as calls on a concrete type. Trait values (`Array[Shape]`),
by contrast, use dynamic dispatch.

## Ownership of type arguments

A type argument can itself be a borrow: `Array[ref User]` holds borrows, `Array[User]` owns its users. Within
generic code, `ref T` borrows a value of whatever `T` is, and `move T` in a return type (as in `Array.clone`'s
`Array[move T]`) means "the owned version of `T`", even when `T` is a borrow.

## Generic traits

Traits take parameters the same way. `Add[T, R]` is implemented once per pair of operand and result types, and
`Iter[T]` once per element type:

```inko
impl Iter[Int] for Countdown { … }
```

## When to use trait values instead

Use `Array[SomeTrait]` (with `value as SomeTrait`) when one collection must hold values of different types. In all
other cases a type parameter with a requirement is more flexible: it accepts borrows, needs no casts, works with
`inline` and `copy` types, and is resolved at compile time.
