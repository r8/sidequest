# About

## The pieces

| Definition | Type | Purpose |
| --- | --- | --- |
| `throw(message, info = ExnError)` | `exn a` | raise an exception; its result type fits anywhere |
| `try(action)` | `e error<a>` | run `action`, returning `Ok(value)` or `Error(exception)` |
| `try(hndl, action)` | `e a` | run `action`, calling `hndl(exception)` if it throws |
| `untry(err)` | `exn a` | the value in an `error<a>`, or throw its exception again |
| `.maybe`, `.default(x)` | | convert an `error<a>` |
| `on-exit(f, action)` | | run `f` whether `action` returns or throws |

`error<a>` is an alias for `result<a, exception>`. An `exception` is a struct of a `message : string` and an
`info : exception-info`. The info is an open type: `ExnError`, `ExnAssert`, `ExnTodo`, `ExnRange`,
`ExnPattern(…)`, `ExnSystem(errno)`, `ExnInternal(name)`, and others a library may add. Match on `err.info` to
treat kinds of exceptions differently.

## Syntax notes

`try` takes its action as a function, so it is written with a block: `try({ … })`, or with a trailing block
`try(fn(err) …) { … }`. In `match try({ … })` the parentheses are required: `match try { … }` is a parse error.
With the `with` statement of a later lesson, `with try fn(err) 0` catches everything in the rest of a block.

## Exceptions as an effect

The standard library declares

```koka
pub effect exn
  final ctl throw-exn(exn : exception) : a
```

and `try` is a handler for it. Nothing in the compiler is special to exceptions: the same machinery gives you
generators, state, backtracking and asynchronous code, as the lessons on effect handlers show. `final ctl` marks
an operation that never resumes, which is why the code after a `throw` never runs.

Because `exn` is tracked in types, a function's signature tells whether it can throw, and handling all of a
function's exceptions removes `exn` from its type. A total function cannot throw, so the type `int -> int` is a
guarantee.

## Exceptions are not for control flow

Exceptions are cheap in Koka, but a `maybe` or `either` result documents an expected failure in the type
itself and forces the caller to deal with it. Use exceptions for failures the immediate caller usually cannot
handle — bad input deep in a parser, a broken invariant — and convert at the boundary with `try`.

## Pattern-match failures

A `match` that misses a case throws an `ExnPattern` exception at run time when the case occurs, so Koka gives the
function the `exn` effect: one declared total with an incomplete match is rejected with "effects do not match".
Prefer complete matches.
