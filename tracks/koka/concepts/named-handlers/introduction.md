# Introduction

A named effect has handlers that are values. `named handler` creates one, and `with h <- named handler …` binds
it for the rest of the block; operations are then called on that value, so several handlers of the same effect
can be active at once:

```koka
named effect dispenser
  fun take-ticket() : int

fun dispenser(first : int, action : (ev<dispenser>) -> e a) : e a
  var next := first
  with d <- named handler
    fun take-ticket()
      next := next + 1
      next - 1
  action(d)

with bakery <- dispenser(1)
with butcher <- dispenser(100)
[bakery.take-ticket, butcher.take-ticket, bakery.take-ticket]   // [1, 100, 2]
```

A handler value has the type `ev<dispenser>`. Calling an operation through it does not add `dispenser` to the
effect, but adds `exn`: the handler might no longer be running when the call happens.
