# About

## throw

`throw expr` is `return Result.Error(expr)`. It is allowed only in methods and closures whose return type is a
`Result`, and since it never produces a value it can appear in any expression position: a `match` case, the `else`
of a refutable `let`, one branch of an `if`.

## try

`try expr`, where `expr` is a `Result[T, E]`, evaluates to the `T` of an `Ok` and returns `Result.Error(e)` for an
`Error`. On an `Option[T]` it evaluates to the value of a `Some` and returns `Option.None` for a `None`. The
surrounding method must return the same kind of value, with a compatible error type. Convert between them with
`ok_or` (option to result), `ok` (result to option) and `map_error` (one error type to another).

A `try` whose value isn't needed is still useful as a check: `try validate(input)` on its own line.

## Designing error types

- An enum of failure cases lets callers decide what to do with each one.
- Give the enum a `message` method or implement `ToString`, so it can be shown to people; implementing `ToString`
  also makes `or_panic` print it.
- Implement `Equal` and `Format` to compare errors in tests and show them in failures.
- Wrap lower-level errors in a case (`case Io(std.io.Error)`) and convert with `map_error` at the boundary.

## Panics

A panic stops the program with a message and a stack trace. It is the response to a bug: a broken invariant, an
index that must exist, an impossible state. Inko deliberately offers no way to catch a panic. Standard library
methods that panic say so in their documentation (`Array.set` on an index out of bounds, `Int` overflow,
`Future.get` on a dropped promise, …), and usually have a non-panicking alternative that returns an `Option` or
`Result`.

`panic(message)` (always available) has the return type `Never`, so it fits anywhere a value is expected, like
`throw`.

## Ignoring errors

The compiler warns when a `Result` is not used. To ignore one deliberately, write `let _ = expression`; anything
else should handle the error, return it, or turn it into a panic with `or_panic` when it can only be a bug.
