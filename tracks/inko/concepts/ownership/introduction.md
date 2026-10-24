# Introduction

Every Inko value has one owner. Assigning, passing, storing or returning an owned value moves it, and the old
variable can't be used afterwards (a compile-time error). When the owner goes away, the value is dropped at once;
there is no garbage collector.

`Int`, `Float`, `Bool`, `Nil` and `String` are value types, copied instead of moved.

To take a value out of a field, swap it: `@item := Option.None` returns the old value. An `fn move` method owns
`self` and can move its fields out, consuming the value it's called on. An `fn move` closure owns what it captures,
so it can assign it.
