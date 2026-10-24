# About

## Why named handlers

An operation of an ordinary effect is handled by the innermost enclosing handler of that effect. That dynamic
lookup is what makes handlers modular, but it means two handlers of the same effect cannot both be used from the
same code: the inner one shadows the outer one (short of `mask`, which skips one handler at a time).

A named effect turns the handler into a first-class value instead. Each `named handler` expression creates a
fresh handler; the operations take it as their first argument, and the value says which handler answers. Typical
uses are resources of which a program has several: files, sockets, counters, random generators with separate
seeds, ledgers.

```koka
named effect reader<a>
  fun ask() : a

fun reader(x : a, action : (ev<reader<a>>) -> e b) : e b
  with r <- named handler
    fun ask() x
  action(r)
```

Named effects can have type parameters like any other effect.

## The shape of a named handler

- `named handler { clauses }` is a function that takes an action of type `(ev<eff>) -> e a` and runs it with the
  new handler as the argument.
- `with h <- named handler …` is the usual way to write it: the rest of the block becomes that action, with the
  handler bound to `h`.
- The clauses are the same as for ordinary handlers: `fun`, `val`, `ctl`, and `return(x)`.
- State lives in a `var` of the enclosing function, so each call of the function that creates the handler has
  its own state.

## Effects

Calling an operation on an `ev` value has the effect `exn`, not the named effect itself. The named effect is
resolved by the value, so it does not need to appear in the type, but the type system cannot prove that the
handler is still on the stack: the `ev` value could have escaped its `with` block (returned, or captured in a
function that is called later). Such a call fails at runtime, which the `exn` accounts for.

## Scoped effects

When that runtime failure is not acceptable, a named effect can be declared `scoped`. The handler's type then
carries a scope variable, and the action must be polymorphic in it, which statically stops the handler from
escaping; the operations then have the effect `<ledger<s>>` rather than `exn`:

```koka
named scoped effect ledger<s::S>
  fun balance() : int

fun open-ledger(start : int, action : forall<s> (ev<ledger<s>>) -> <ledger<s>|e> a) : e a
  with l <- named handler
    fun balance() start
  action(l)
```

This is more precise and more verbose; the plain `named effect` is simpler to start with.

## Named handlers versus parameters

A named handler passed around as a parameter can look like an ordinary object passed to functions. The
difference is that its operations run in the handler's context: they can use the state, effects and
resumptions available where the handler was installed, not where the operation is called.
