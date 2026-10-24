# Introduction

In a `ctl` clause, `resume` is a function that runs the rest of the handled computation with the operation's
answer and returns what the computation ends with. Calling it more than once runs the rest of the computation
once per call, so a handler can explore every answer and combine the results:

```koka
effect toss
  ctl toss() : bool

fun every-way(action : () -> <toss|e> a) : e list<a>
  with handler
    return(x) [x]
    ctl toss() resume(True) ++ resume(False)
  action()
```

A clause that does not resume abandons that path, which together with resuming several times gives search with
backtracking. Only the code after the operation runs again; code before it runs once.
