# About

## State in the installing function

Koka has no special syntax for stateful handlers: a handler's state is a `var` of the function that installs it.

```koka
fun numbering(action : () -> <ticket|e> a) : e a
  var next := 1
  with fun ticket()
    val number = next
    next := next + 1
    number
  action()
```

The clauses close over `next`, so every `ticket()` the action performs sees the value the previous one left
behind. Each call of `numbering` creates its own `next`; nested handlers of the same effect keep separate state,
and the innermost one answers.

## Why the type stays clean

A `var` has the `local` effect, but Koka knows it cannot escape the function that declares it, so the effect is
removed when that function returns. The handler function's type mentions only what the action brings, `e`, and
the effect it handles disappears: state is an implementation detail of the handler.

## A state effect

The classic example makes the state itself the effect:

```koka
effect state<s>
  fun get() : s
  fun put(x : s) : ()

fun state(init : s, action : () -> <state<s>|e> a) : e (a, s)
  var current := init
  with handler
    return(x) (x, current)
    fun get() current
    fun put(x) current := x
  action()
```

Code using `get` and `put` reads like imperative code, yet the handler decides where the state lives — or
whether there is any, as a test handler can answer `get` with a constant.

## State and `ctl` operations

With `ctl` clauses that resume more than once, a `var` in the installing function is shared by all the
resumptions: what one branch writes, the next one sees. When each branch needs its own copy, the state must be
part of what is passed along instead — the lesson on combining handlers shows how the order of a state handler
and a choice handler decides this.

## Alternatives

When a computation only needs to read a value, an `effect val` and `with val x = …` are simpler than state. When
state must outlive the handler or be shared between unrelated parts of a program, a reference (`ref`) with the
`st<h>` effect is the tool, at the price of that effect showing in the types.
