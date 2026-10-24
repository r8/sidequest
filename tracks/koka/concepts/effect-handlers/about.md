# About

## Handler expressions

`handler { <clauses> }` is a value: a function that takes an action `() -> <eff|e> a`, runs it, and handles every
operation of `eff` that it performs. It needs one clause per operation, or the compiler reports "operator … is not
handled".

```koka
val bright-room = handler
  fun brightness() 80
  fun dim(by) ()

bright-room(reading-light)
```

`handle(action)` followed by the clauses applies a handler directly to an action. With `with`, which passes the
rest of the block as the action, the common forms are:

```koka
with handler
  fun brightness() 30
  fun dim(by) ()
with fun log(message) println(message)    // one operation: no `handler` keyword
with val room = "attic"                   // a value operation
```

## What a clause can do

A `fun` clause receives the operation's arguments, and its result is returned at the operation's call site: the
action continues as if it had called an ordinary function. A clause can use `var`s of the enclosing function
(handler state, a later lesson), other effects (a clause using `println` gives the handler's caller the `console`
effect), and parameters of the function that installs the handler.

## Handler functions

The idiom is to wrap a handler in a function that takes the action last, so it reads as `with fixed-lamp(70)`:

```koka
fun fixed-lamp(level : int, action : () -> <lamp|e> a) : e a
  with handler
    fun brightness() level
    fun dim(by) ()
  action()
```

The type shows exactly what it does: the action may use `lamp` and any other effects `e`, and only `e` is left
afterwards. This is how Koka code stays testable without mocks — production installs a handler that talks to the
hardware, the tests install one that returns fixed values.

## Nesting and the innermost handler

An operation is answered by the innermost handler of its effect. Clauses run in the handler's context, outside
the action, so an operation performed _inside_ a clause goes to the next handler out. When a handler handles the
same effect it uses, write `override`, which also hides the outer handler from the action and keeps the type
`(action : () -> <log|e> a) : <log|e> a`:

```koka
fun shouting(action : () -> <log|e> a) : <log|e> a
  with override fun log(message) log(message.to-upper)
  action()
```

Without `override`, the action's type would need two `log` labels, `<log,log|e>`: Koka allows duplicate labels in
effect rows, one per nested handler, and `mask` reaches past the innermost one. Those are rarely needed.

## Beyond `fun`

Handlers can also have a `return(x)` clause that transforms the action's final result, `ctl` clauses that decide
whether and how often to resume, and `finally` clean-up; later lessons cover them.
