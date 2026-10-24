# About

## What `return` does

Without a `return` clause, a handler's result is its action's result. With one, the handler's result is

- `body`, with `x` bound to the action's result, when the action finishes normally;
- the value of a `ctl` clause that returns without resuming, which skips `return` entirely.

```koka
with handler
  return(x) "finished: " ++ x
  ctl leave() "left early"
```

The clause's type is the handler's result type, independent of the action's: `(a, int)`, `list<a>`, or a value
that ignores `x`, as `return(_) left`.

## Typical uses

- **Pairing with state**: `return(x) (x, count)` reports what the handler kept track of.
- **Finishing a log**: lists built with `Cons` come out backwards; `return(x) (x, log.reverse)` fixes the order
  once.
- **Wrapping**: `return(x) Just(x)` next to an aborting `ctl` clause that returns `Nothing` — an alternative to
  writing `Just(action())` after the `with`.
- **Collecting all results**: with operations that resume several times, `return(x) [x]` makes every finished
  branch a one-element list, and the clauses concatenate them (`resume(True) ++ resume(False)`).

## `with return`

`with return(x) body` is a handler with only a return clause: it handles no operations and transforms the result
of the rest of the block. `with return(x) ()` is a short way to discard it.

## Return clauses and resumptions

In a `ctl` clause, `resume(v)` returns the handler's final result — after the `return` clause has run on that
branch. So in a handler with `return(x) (x, count)`, a clause doing `val (r, n) = resume(v)` receives the
already-paired result.
