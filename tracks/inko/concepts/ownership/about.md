# About

## Owned references

A variable, field or collection holding a value of type `T` (not `ref T` or `mut T`) owns it. Ownership moves on:

- assignment (`let b = a`),
- passing an argument of an owned type,
- storing in a field or a collection (`push`, `set`),
- returning from a method or closure,
- matching on the value or destructuring it with `let`,
- capturing it in an `fn move` closure.

Using a moved variable is a compile-time error. A variable can be given a new value after a move (if it's
`let mut`), which makes it usable again.

## Drops

A value is dropped when its owner goes away: a local variable at the end of its scope (in reverse order of
definition), a field when its object is dropped (in reverse order of definition), a collection's values when the
collection is. Dropping runs the type's destructor, if it has one, and frees the memory. `std.drop.drop(value)` drops
a value immediately; `let _ = value` does the same.

## Partial moves

An `fn move` method can move fields out of `self`; the remaining fields are dropped individually, and the object
itself is _partially dropped_ (its destructor doesn't run). Types with a custom destructor (`Drop`) can't have their
fields moved out this way.

## Swaps

`target := value` assigns and returns the previous value, for variables and fields alike. It is the way to take
something out of a field in an `fn mut` method:

```inko
fn pub mut take_all -> Array[String] {
  @items := []
}
```

## Conditional moves

The compiler tracks moves through branches and loops. A value moved in some branches is considered moved after the
`if`/`match`, unless every branch that moves it also assigns a new value. A value from outside a loop that is moved
in the loop must be reassigned before the end of the iteration.

## Value types

`Int`, `Float`, `Bool`, `Nil`, `String`, `copy` types, `ref` types and processes are copied (or have their reference
count increased) on a move, so the original stays usable. The value-types lesson covers them.

## Borrowing while moving

Owned values can be moved while borrows to them exist. If an owned value is _dropped_ while still borrowed, the
program panics; that is the subject of the borrowing lesson.
