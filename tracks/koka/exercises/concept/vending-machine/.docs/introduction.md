# Introduction

## Throwing

When a function cannot produce a sensible result — not enough money, a missing item — it can _throw an
exception_ instead of returning:

```koka
fun withdraw(balance : int, amount : int) : exn int
  if amount > balance then throw("insufficient funds") else balance - amount
```

`throw(message)` stops the function, and every function waiting for its result, until something catches the
exception. Because `throw` has the `exn` effect, so does every function that may reach it, as the previous lesson
showed: `withdraw`'s type warns its callers. An exception no one catches ends the program with its message.

`throw` can take a second argument, the kind of exception, from the type `exception-info`: `ExnError` (the
default), `ExnRange` for indices out of range, `ExnTodo` for unwritten code — as in every stub — and a few more.

## Catching into a value

`try` runs a function and turns the exception, if any, into a value. Give it the code as a block, which is a
function without parameters:

```koka
val ok  = try({ withdraw(10, 3) })     // Ok(7)
val bad = try({ withdraw(10, 30) })    // Error(…)
```

The result has the type `error<int>`, with two constructors: `Ok(value)` for a normal result and `Error(exn)` for
an exception. An `exception` carries its `message` and its `info`. Match on it like on a `maybe`:

```koka
fun balance-text(balance : int, amount : int) : string
  match try({ withdraw(balance, amount) })
    Ok(left) -> "left: " ++ left.show
    Error(err) -> "refused: " ++ err.message
```

Note the parentheses in `match try({ … })`: without them the block is read as the start of the match.

When the message does not matter, convert the result:

- `.maybe` turns `Ok(x)` into `Just(x)` and an error into `Nothing`;
- `.default(x)` gives the value, or `x` for an error;
- `untry` turns an `error<a>` back into a value, throwing the exception again if there was one.

```koka
try({ withdraw(10, 30) }).default(10)    // 10
```

## Catching with a handler

`try` also takes a function to call with the exception, as its first argument. The result is then either the
block's value or the handler's:

```koka
fun withdraw-or-zero(balance : int, amount : int) : int
  try(fn(err) 0) { withdraw(balance, amount) }
```

The block is a trailing lambda, as with `map`. Notice the types: `withdraw` has the `exn` effect, but
`withdraw-or-zero` is total. Catching an exception _handles_ the `exn` effect, so it disappears from the type —
the compiler checks that nothing can escape.

## Exceptions are just an effect

`exn` is not built into Koka in any special way. It is declared in the standard library as an effect with one
operation, `throw-exn`, and `try` is a _handler_ for that effect: it decides what happens when the operation is
performed. Later lessons show how to declare effects of your own — and exceptions are only the simplest of them.

## Exceptions or values

An exception suits a failure that the immediate caller will usually not deal with, and that should travel up
until someone can. When every caller should decide on the spot, return a `maybe` or an `either` instead, so the
type forces the decision. `try` converts the one into the other in a single line, so either choice can be undone.
