# Introduction

## Your own effects

The effects in a function's type so far came from the standard library: `exn` from `throw`, `div` from
recursion Koka cannot prove finite, `console` from `println`. Koka lets you declare effects of your own. An effect
declaration names the effect and lists its _operations_:

```koka
effect lamp
  fun brightness() : int
  fun dim(by : int) : ()
```

An operation is called like a function, and using one adds the effect to the caller's type, just like `throw`
adds `exn`:

```koka
fun reading-light() : lamp string
  if brightness() > 50 then dim(10)
  "brightness " ++ brightness().show
```

The declaration says _what_ can be asked, not how it is answered: `reading-light` does not know where
`brightness` comes from. That is the job of a handler. Until one is installed, the effect stays in the type, and
a program whose `main` still has an unhandled `lamp` effect does not compile.

An effect with a single operation of the same name can be declared in one line:

```koka
effect fun log(message : string) : ()
```

and an operation that just provides a value is declared with `val` and used without parentheses:

```koka
effect val room : string

fun label() : room string
  "lamp in the " ++ room
```

Mark an effect `pub`, like a function, when other modules use or handle it.

## Handlers

A handler gives each operation a meaning. `handler` followed by one clause per operation is a function that takes
an action, runs it, and answers every operation the action performs:

```koka
val bright-room = handler
  fun brightness() 80
  fun dim(by) ()

bright-room(reading-light)    // "brightness 80"
```

A `fun` clause is called with the operation's arguments, and its result becomes the result of the operation at
the call site: the action carries on as if it had called an ordinary function. A handler must have a clause for
every operation of the effect.

Most handlers are installed with `with`, which hands them the rest of the block as their action:

```koka
fun demo() : string
  with handler
    fun brightness() 30
    fun dim(by) ()
  reading-light()
```

For an effect with one operation the `handler` keyword can go, and a `val` operation is bound with `with val`:

```koka
fun demo-log() : console string
  with fun log(message) println("> " ++ message)
  with val room = "attic"
  log("starting")
  label()
```

The handler _discharges_ the effect: `demo` has no `lamp` in its type, because nothing outside it can see the
operations any more. The clause itself may use other effects — `println` gives `demo-log` the `console` effect.

## Handlers as functions

A handler is often wrapped in a function that takes the action as a parameter, so callers can use it with `with`.
Its type says which effect it removes: the action may use `lamp` plus any other effects `e`, and the result has
only `e` left:

```koka
fun fixed-lamp(level : int, action : () -> <lamp|e> a) : e a
  with handler
    fun brightness() level
    fun dim(by) ()
  action()

fun demo2() : string
  with fixed-lamp(70)
  reading-light()
```

The same code can now run against a real lamp, a fixed level in a test, or anything else, without changing
`reading-light`.

## Where a clause runs

A clause runs in the context of the handler, not of the call: when it performs an operation of some other
effect, the handlers _outside_ this one answer it. To change the behaviour of an effect that an outer handler
already provides, a handler can call the very operation it handles — marked `override`, the clause's own call
goes to the outer handler, and the types stay simple:

```koka
fun shouting(action : () -> <log|e> a) : <log|e> a
  with override fun log(message) log(message.to-upper)
  action()
```

Inside `shouting`, every `log` is passed on upper-cased to whatever handles `log` further out.
