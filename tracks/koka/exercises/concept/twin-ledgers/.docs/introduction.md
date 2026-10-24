# Introduction

## One effect, several handlers

An ordinary effect operation goes to the innermost handler of its effect. That is what you want for a single
service, but sometimes a program needs two of the same kind at once: two counters, two files, two connections.
With ordinary handlers the inner one would answer every operation.

A _named_ effect solves this. Its handlers are values, and every operation is performed through one of them:

```koka
named effect dispenser
  fun take-ticket() : int
```

## Named handlers

`named handler` creates a handler of a named effect. Used with `with … <-`, it binds the handler to a name for
the rest of the block, where the operations are called on it like functions on a value:

```koka
fun dispenser(first : int, action : (ev<dispenser>) -> e a) : e a
  var next := first
  with d <- named handler
    fun take-ticket()
      val ticket = next
      next := next + 1
      ticket
  action(d)
```

The handler value has the type `ev<dispenser>` (an _evidence_ of the effect). The operation takes it as its
first argument, so `d.take-ticket()`, `d.take-ticket` and `take-ticket(d)` are the same call.

A handler function like `dispenser` above is the usual shape: it sets up the state, creates the named handler
and passes it to an `action` that takes the `ev` as its parameter. Each call creates a separate handler with
its own `var`:

```koka
dispenser(1) fn(bakery)
  dispenser(100) fn(butcher)
    [bakery.take-ticket, butcher.take-ticket, bakery.take-ticket]
// [1, 100, 2]
```

or, with `with`:

```koka
with bakery <- dispenser(1)
with butcher <- dispenser(100)
[bakery.take-ticket, butcher.take-ticket, bakery.take-ticket]
```

Both handlers are active at the same time, and which one answers is decided by the value the operation is called
on, not by nesting.

## Passing handlers around

Since a named handler is a value, it can be passed to functions and stored in a list or a tuple. A function
that works with a handler takes it as a parameter of type `ev<…>`:

```koka
fun serve(bakery : ev<dispenser>, butcher : ev<dispenser>) : exn list<int>
  [bakery.take-ticket, butcher.take-ticket]
```

## The effect of a named operation

The type of `serve` has no `dispenser` effect, but it has `exn`. Calling an operation through a named handler
does not add the named effect to the type: the handler is named explicitly, so there is nothing to look up.
Instead, the compiler cannot prove that the handler is still running when the call happens (an `ev` value
could be stored and used after its `with` block has ended), so every such call may throw, and has the `exn`
effect.

## Return clauses

A named handler can have a `return` clause, like any handler, to transform the result of the action it handles:

```koka
with d <- named handler
  return(x) (x, next)
  fun take-ticket() …
```

## Pitfalls

- An operation of a named effect cannot be called without a handler value: `take-ticket()` on its own is an
  error ("function has not enough arguments"), as the operation needs its `ev`.
- Keep an `ev` value inside the block that created it; using it after the handler has finished is the error
  the `exn` stands for.
- A `var` belongs to the call of the function that declares it, so each handler function call gets a fresh
  one: two dispensers never share their counters.
