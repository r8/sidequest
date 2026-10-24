# Introduction

## Handlers with state

A handler is installed by an ordinary function, so it can use that function's local variables. A `var` declared
before `with handler` lives as long as the handled computation, and the clauses can read and update it every time
an operation is performed. That gives an effect memory:

```koka
effect fun spend(amount : int) : bool

fun shopping() : spend list<string>
  val bread = spend(3)
  val cake = spend(12)
  val tea = spend(4)
  [if bread then "bread" else "", if cake then "cake" else "", if tea then "tea" else ""]

fun with-budget(money : int, action : () -> <spend|e> a) : e a
  var left := money
  with fun spend(amount)
    if amount <= left then
      left := left - amount
      True
    else False
  action()
```

`with-budget(10, shopping)` is `["bread", "", "tea"]`: after the bread, only 7 is left, so the cake is refused and
the tea is not. The action never sees `left`; it only performs `spend`.

Each call of `with-budget` makes a fresh `left`, so two budgets never share their money. And because the
variable is local to `with-budget`, its use of state does not show in the type: the result is just `e a`, the
effects of the action other than `spend`.

## Return clauses

A handler's result is normally the action's result. A `return` clause changes that: `return(x) body` runs once,
when the action finishes, with the action's result as `x`, and its value becomes the result of the handler. The
clause can see the handler's state as it is at the end:

```koka
fun with-budget-left(money : int, action : () -> <spend|e> a) : e (a, int)
  var left := money
  with handler
    return(x) (x, left)
    fun spend(amount)
      if amount <= left then
        left := left - amount
        True
      else False
  action()
```

`with-budget-left(20, shopping)` is `(["bread", "cake", "tea"], 1)`. A `return` clause needs the `handler` form,
since it sits next to the operation clauses. Its result may have any type, unrelated to the action's: the
handler's type says so, as `e (a, int)` here. It may also ignore `x` altogether:

```koka
fun money-left(money : int, action : () -> <spend|e> a) : e int
  var left := money
  with handler
    return(_) left
    fun spend(amount)
      if amount <= left then { left := left - amount; True } else False
  action()
```

## Building results in state

A common use of handler state is collecting what the action does: each operation adds to a list in a `var`, and
the `return` clause hands the list back. Adding to the front with `Cons` is cheap, so lists are usually built
backwards and reversed once, in the `return` clause.

## When the return clause runs

The `return` clause runs only when the action finishes normally. If a `ctl` clause of the same handler returns
without resuming, the handler's result is that clause's value and `return` is skipped:

```koka
effect ctl leave() : a

fun errand() : string
  with handler
    return(x) "finished: " ++ x
    ctl leave() "left early"
  leave()
  "shopping"
```

`errand()` is `"left early"`.

A handler made only of a return clause is allowed too, as `with return(x) …`. It transforms the result of the
rest of the block and handles nothing.
