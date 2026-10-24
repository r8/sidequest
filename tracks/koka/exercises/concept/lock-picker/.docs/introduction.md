# Introduction

## Resuming more than once

In a `ctl` operation clause, `resume` is an ordinary function: calling it runs the rest of the handled
computation, from the point where the operation was performed, and returns what that computation ends with.
Nothing stops a clause from calling it twice. Each call runs the rest of the computation again, with a
different answer to the operation, and the clause can combine the results.

Take an effect for tossing a coin:

```koka
effect toss
  ctl toss() : bool
  ctl spoil() : a

fun two-coins() : toss string
  val first = toss()
  val second = toss()
  if first == second then "pair" else "mixed"
```

A handler that answers each toss both ways explores every possibility:

```koka
fun every-way(action : () -> <toss|e> a) : e list<a>
  with handler
    return(x) [x]
    ctl toss() resume(True) ++ resume(False)
    ctl spoil() []
  action()

every-way(two-coins)   // ["pair", "mixed", "mixed", "pair"]
```

Follow the types: the return clause turns each finished computation into a one-element list, so the handler's
result is a list, and so is the result of every `resume`. The first `toss` resumes twice; inside each of those
runs the second `toss` resumes twice more, so `two-coins` finishes four times. The order of the results is the
order of the resumptions: `True` first here.

## Giving up on a path

An operation whose clause does not resume abandons that path. `spoil` has the result type `a`: it never returns
to its caller, so it can stand wherever a value of any type is expected. Its clause answers `[]`, no results,
and the other paths carry on:

```koka
every-way { val c = toss(); if c then spoil() else "tails" }   // ["tails"]
```

That is search with backtracking: try a choice, and when it leads nowhere, the handler goes back to the most
recent choice and tries the next answer.

## Combining the resumptions

The clause decides what to do with the results. It need not collect them; this handler keeps the best score:

```koka
fun best-score(action : () -> <toss|e> int) : e int
  with handler
    ctl toss() max(resume(True), resume(False))
    ctl spoil() 0
  action()

best-score { if toss() then 3 else 5 }   // 5
```

Without a `return` clause the computation's own result is the handler's result, here an `int`.

A clause can also look at one result before deciding whether to resume again. This one only tries `False` when
`True` led to nothing:

```koka
ctl toss()
  val heads = resume(True)
  if heads.is-empty then resume(False) else heads
```

Resuming lazily like this matters, because every resumption is real work: the rest of the computation runs
again in full each time.

## What runs again

Only what comes after the operation is repeated. Code before the first `toss` runs once; code after it runs once
per resumption:

```koka
var rolls := 0
val r = every-way
  rolls := rolls + 1
  toss()
// r == [True, False], rolls == 1
```

A `var` declared outside the handler, like `rolls` here, is shared by every path, so anything a path adds to it
is still there when the next path runs.

## Pitfalls

- Use `ctl`, not `fun`, for an operation that resumes more than once or not at all: a `fun` clause always
  resumes exactly once with its result.
- The number of paths multiplies with each choice: three choices of ten digits are a thousand runs.
- The handler must give every path a result of the same type, so a clause that abandons a path returns the empty
  value of that type (`[]`, `0`, `Nothing`).
