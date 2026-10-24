# About

## `ctl` clauses

A `ctl` clause runs at the handler, after the computation that called the operation has been suspended. It
receives the operation's arguments and an implicitly bound `resume` function, and it can

- **resume once**: `resume(x)` continues at the call site with `x`; `with ctl op() resume(v)` behaves like
  `with fun op() v`;
- **not resume**: the clause's value is returned from the handled block, and the suspended rest is dropped — the
  shape of exceptions, early exits and "give up" operations;
- **resume and then continue**: `resume(x)` returns what the rest of the handled block finally produced, so the
  clause can inspect or transform it (count, annotate, wrap) before returning it;
- **resume more than once**, which a later lesson covers (backtracking, all solutions).

The clause's result has the type of the handled block, which is why aborting handlers usually wrap the normal
result: `Just(action())` below, `Nothing` in the clause.

## `final ctl`

`final ctl op(…) body` is a clause that never resumes. Writing `final` documents that, lets the compiler avoid
capturing a resumption, and runs `finally` clean-up handlers eagerly. The standard library's exceptions are
exactly this: `exn` has one operation, `final ctl throw-exn(exn : exception) : a`, and `try` handles it.

## Result types of operations

An operation declared `ctl give-up(reason : string) : a` has a type variable as its result, so a call fits
wherever any type is expected, like `throw`. In return, a handler has no value of that unknown type to resume
with, so such an operation is in practice one that never returns. Operations meant to be resumed have a concrete
result type: `ctl hint(puzzle : string) : string`.

## Declaring `ctl` versus `fun`

The declaration fixes what handlers are allowed: `fun` operations must always resume once (handlers write
`fun` or `val` clauses), `ctl` operations allow everything. A handler for a `ctl` operation may still write a
`fun` clause when it just returns a value, which is also faster. `fun` is the better default; declare `ctl` when
some handler needs control.

## Order of effects in clauses

A clause runs in the handler's context: operations it performs are handled outside the handler. A clause may call
a different operation (turn a `hint` into a `give-up`), and with `override` it may call the same operation to
reach the outer handler. Code after `resume` runs after the rest of the handled block finished, so effects
performed there happen in reverse order of the operations that caused them.
