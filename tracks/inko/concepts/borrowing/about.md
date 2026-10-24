# About

## Kinds of reference

| Type | Meaning | Allows |
| --- | --- | --- |
| `T` | owned | everything, including moving and dropping |
| `ref T` | immutable borrow | reading, `fn` methods |
| `mut T` | mutable borrow | reading, `fn` and `fn mut` methods, assigning `let mut` fields |
| `uni T` | unique (see the unique values lesson) | moving between processes |

Any number of borrows of either kind may exist at once.

## Automatic borrowing

| Value passed | Expected | Passed as |
| --- | --- | --- |
| `T` | `ref T` | `ref T` |
| `T` | `mut T` | `mut T` |
| `mut T` | `ref T` | `ref T` |
| `mut T` | `mut T` | `mut T` |
| `ref T` | `ref T` | `ref T` |

A `ref T` can't be passed as `mut T`, and borrows can't be passed where an owned `T` is expected.

## Borrow counting

Heap-allocated values carry a borrow count, incremented when a borrow is created and decremented when it is
dropped. Dropping an owned value checks the count and panics if it's not zero. Because the check happens at drop
time rather than at each use, it costs little, allows patterns that compile-time borrow checking makes hard (graphs,
doubly linked lists, borrows stored in fields), and fails deterministically: the same input fails in the same place.

Common causes of the panic:

- calling `iter` on a temporary (`[1, 2].iter`), which is dropped while the iterator borrows it;
- a closure borrowing a local variable, returned from the method that owns the variable;
- clearing or reassigning a collection while holding a borrow of one of its values;
- a value storing a borrow of something that is dropped first (variables are dropped in reverse order of
  definition).

## Borrows of value types

`Int`, `Float`, `Bool`, `Nil` and `String` are never really borrowed: `ref Int` behaves exactly like `Int`, and the
compiler warns that borrowing a value type is redundant.

## Borrows in fields

Fields may hold borrows (`let @owner: ref Person`). Such a type must not outlive the borrowed value. It's often
simpler to store an index or a key and look the value up when needed.

## Inline types

Borrowing an `inline` type copies its stack data and increments the borrow counts of any heap values inside it.
Assignments to an inline type's fields are only visible through borrows created afterwards.
