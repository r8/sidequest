# Introduction

A `return(x)` clause in a handler runs once, when the handled action finishes, with the action's result as `x`.
Its value becomes the handler's result, and it may have a different type:

```koka
fun with-budget-left(money : int, action : () -> <spend|e> a) : e (a, int)
  var left := money
  with handler
    return(x) (x, left)
    fun spend(amount)
      if amount <= left then { left := left - amount; True } else False
  action()
```

The clause sees the handler's state as it is at the end, which makes it the place to hand back a count or a log
(reversed once, if it was built with `Cons`). It is skipped when a `ctl` clause of the same handler returns
without resuming.
