# About

## Syntax

```inko
fn { 42 }                            # no arguments
fn (x) { x + 1 }                     # argument type inferred from context
fn (x: Int) -> Int { x + 1 }         # fully typed
fn move (x: Int) { values.push(x) }  # moving closure
```

`closure.call(args)` runs it. Argument and return types are inferred when the closure is passed directly to an
argument of a closure type (`fn (Int) -> Int`); otherwise they must be written out.

## Closure types

`fn (A, B) -> R` is a closure taking an `A` and a `B` and returning an `R`; `fn (A)` returns `Nil`; `fn` takes and
returns nothing. Closures are owned values: passing one to an argument of type `fn (Int) -> Int` moves it. A closure
can only be called through an owned value or a mutable borrow, so an argument that should only borrow a closure is
typed `mut fn (Int) -> Int`.

## Captures

| Captured variable | Inside a closure | Inside an `fn move` closure |
| --- | --- | --- |
| `Int`, `Float`, `Bool`, `String` (value types) | a copy | a copy |
| an owned value or `mut` borrow | `mut` borrow | moved in, exposed as a `mut` borrow |
| a `ref` borrow | `ref` borrow | `ref` borrow |

Non-moving closures can't assign captured variables. `fn move` closures can, but the variable is moved into the
closure and can't be used outside it afterwards. Because a closure may be called many times, captured values are
always exposed as borrows inside the body, even in an `fn move` closure: you can't move a captured value out of a
closure.

A closure that borrows a value must not outlive it. Returning a non-moving closure that borrows a local array or an
owned argument compiles, but panics when the method returns ("can't drop a value of type 'Array' as it still has 1
reference(s)"), because the value is dropped while the closure still borrows it; returning an `fn move` closure
avoids that.

## `self` in closures

Inside a method, a closure can use `self` (and fields). In a trait's default method, where `self` has the type
`Self`, only `fn move` closures can capture it, and only when `self` is owned.

## Where closures appear

- iterator methods: `map`, `select`, `reduce`, `find`, `any?`, `all?`, …
- `Int.times`, `Array.sort_by`, `Array.remove_if`
- `Option.map`, `Option.or_else`, `Result.map_error`, …
- `std.test`: every test is a closure, `t.test('name', fn (t) { … })`.
