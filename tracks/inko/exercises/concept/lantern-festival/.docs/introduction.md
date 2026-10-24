# Introduction

Because every value has a single owner, Inko knows exactly when a value stops being used: when its owner drops it.
A type can run code at that moment by defining a _destructor_. Destructors are how a file closes itself, a socket
disconnects, or a lock is released, without anyone having to remember to do it.

## The Drop trait

A destructor is the `drop` method of the `Drop` trait, from the `std.drop` module:

```inko
import std.drop (Drop)

type pub Ticket {
  let @number: Int
  let @used: mut Array[Int]
}

impl Drop for Ticket {
  fn mut drop {
    @used.push(@number)
  }
}
```

`drop` is always a private `fn mut` method: writing `fn pub drop` or a plain `fn drop` is a compile-time error. You
never call it yourself; Inko calls it when the value is dropped.

The `@used` field above is a mutable borrow of an array that lives somewhere else, so the ticket can record its
number there when it goes away. That array must outlive the tickets, or dropping it would panic because the tickets
still borrow it.

## When values are dropped

A value is dropped when its owner lets go of it:

- a local variable, at the end of the scope (the method, the loop body, or a `{ … }` block) that defined it;
- a field, when the value holding it is dropped;
- a value in a collection, when the collection is dropped or the value is removed and not kept;
- a variable or field, when it is assigned a new value (the old value is dropped);
- a value moved into a method that doesn't keep it, at the end of that method.

A value that was _moved_ elsewhere isn't dropped by its old owner; the new owner drops it later.

## Drop order

The order is fixed and predictable:

- local variables are dropped in _reverse_ order of definition: the last one defined is dropped first;
- when a value with fields is dropped, its destructor runs _first_, while the fields are still there, and then the
  fields are dropped, in reverse order of definition;
- an array drops its values from first to last.

```inko
let used = []

{
  let _a = Ticket(number: 1, used: used)
  let _b = Ticket(number: 2, used: used)
}

used # => [2, 1]
```

(The variables start with `_` because they're never read, which would otherwise draw a warning. A plain `_` would
drop the value immediately instead.)

## Dropping early

`std.drop.drop(value)` takes ownership of a value and drops it right away, which is clearer than waiting for the end
of the scope:

```inko
import std.drop (drop)

let ticket = Ticket(number: 3, used: used)

drop(ticket)
used # => [3]
```

There's nothing special about `drop`: it's an ordinary method whose argument is owned and goes away at its end. Any
method that takes an owned value and doesn't move it elsewhere drops it when it returns.

## What a destructor can't do

- A destructor must not keep a borrow of `self` anywhere; if it does, dropping `self` panics afterwards.
- Types with a destructor can't be taken apart: `match` can't destructure them, and an `fn move` method can't move
  their fields out (that would skip the destructor). Return a value through a method or a swap instead.
- `copy` types can't have destructors at all. `inline` and regular types can.

## Destructors and borrows

Dropping a value that is still borrowed panics, and that includes values a destructor touches. When a destructor
writes into a borrowed collection, as the `Ticket` above does, make sure the collection is defined before (and so
dropped after) the values that write into it.
