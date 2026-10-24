# About

## Declaring an effect

```koka
effect lamp
  fun brightness() : int
  fun dim(by : int) : ()
```

declares the effect type `lamp` and two operations. Each operation has a parameter list and a result type, and
each one's kind restricts how handlers may define it:

- `fun` operations always return to their caller exactly once with the clause's result. Most operations are
  like this, and they are as cheap as a call through a function pointer.
- `val` operations (`effect val room : string`) are `fun` operations without arguments whose handler binds a
  value; they are used like a value, without parentheses.
- `ctl` operations are general _control_ operations: their handler receives the rest of the computation as an
  explicit `resume` function and may call it once, never, or several times. Exceptions, generators and
  backtracking are built from them; a later lesson covers them.

An effect with one operation of the same name has a one-line form: `effect fun log(message : string) : ()`,
`effect val room : string`, `effect ctl fail() : a`.

## Type parameters

Effects can be polymorphic, like types: `effect state<s> { fun get() : s; fun put(x : s) : () }` gives
`state<int>`, `state<string>` and so on. A `ctl` operation's result can also be a fresh type variable, as in
`ctl fail() : a` — the operation can stand in for a value of any type because it never returns.

## Effects in types

Calling an operation adds its effect to the caller's inferred type, and the usual rules apply: `fun label() : room
string` lists it, a higher-order function passes it through `e`, and `main` must have none left. The compiler
reports "there are unhandled effects for the main expression" otherwise.

## Visibility

`pub effect` exports the effect type and its operations, so other modules can both use and handle it. A private
effect is a module's own business — useful for an implementation detail handled inside the module.

## Related

`linear effect` declares an effect whose handlers may only use `fun` and `val` clauses, which lets the compiler
optimise effect-polymorphic code further; `named effect` declares an effect whose handlers are passed around as
first-class values (a later lesson).
