# About

## Defining a destructor

```inko
import std.drop (Drop)

impl Drop for Lock {
  fn mut drop {
    @state.release
  }
}
```

The method must be `fn mut drop`, without `pub` and without arguments or a return value. It is called exactly once,
when the value is dropped, and then the fields are dropped in reverse order of definition.

## What triggers a drop

- The end of the scope owning a local variable (methods, closures, loop bodies, `{ … }` blocks).
- Assigning a variable or field a new value with `=` (`:=` returns the old value instead).
- `let _ = value`, and `std.drop.drop(value)`.
- Dropping a collection or object that owns the value.
- A reference-counted value (`type ref`, `String`, processes) losing its last reference.

Moved values are dropped by their final owner. Partially moved values (whose fields were moved out by a `match` or
an `fn move` method) don't run a destructor, which is why types with a destructor can't be partially moved.

## Order

Locals: reverse order of definition. Fields: after the owner's destructor, in reverse order of definition. Arrays:
from the first value to the last. Enums: the values of the active case, in reverse order.

## Rules and pitfalls

- A destructor that stores a borrow of `self` somewhere makes the drop panic, since `self` is still borrowed.
- Dropping a value that is borrowed elsewhere panics; values that destructors write into must outlive them.
- `copy` types can't implement `Drop`; use `inline` for a stack-allocated type with a destructor.
- Types with a destructor can't be matched against with patterns that destructure them.
- Destructors of processes (`type async`) run when the process is dropped, after it finishes its remaining
  messages.

## Uses

Destructors release what a value holds: files and sockets close themselves (`std.fs.file`, `std.net.socket`), and
`Future` and `Promise` disconnect from each other. The pattern of tying a resource to a value's lifetime is often
called RAII.
