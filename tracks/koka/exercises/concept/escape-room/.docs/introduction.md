# Introduction

## Operations that take control

A `fun` operation always returns to its caller: the handler computes a result and the code that called the
operation carries on with it. Koka's general kind of operation is the _control_ operation, declared with `ctl`.
Its handler clause decides what happens next:

```koka
effect ctl too-heavy(item : string) : a

fun pack(items : list<(string, int)>) : too-heavy int
  items.foldl(0) fn(total, item)
    val (name, kg) = item
    if kg > 20 then too-heavy(name) else total + kg
```

Inside a `ctl` clause, Koka binds a function named `resume`. Calling `resume(x)` continues the computation at the
call site of the operation, as if the operation had returned `x`. A `ctl` clause that always resumes once behaves
like a `fun` clause:

```koka
effect ctl ask-weight(item : string) : int

fun weigh-all(items : list<string>) : ask-weight int
  items.map(ask-weight).sum

fun by-letters(items : list<string>) : int
  with ctl ask-weight(item) resume(item.count)
  weigh-all(items)        // by-letters(["tent", "rope"]) == 8
```

## Not resuming

A clause does not have to call `resume`. When it returns without resuming, the rest of the handled computation
is abandoned, and the clause's value becomes the result of the whole handled block — of the `with` and everything
below it:

```koka
fun pack-or-zero(items : list<(string, int)>) : int
  with ctl too-heavy(name) 0
  pack(items)
```

`pack-or-zero([("tent", 5), ("anvil", 50)])` is 0: the fold stops at the anvil and never finishes. This is how
exceptions work in Koka, and `throw` is in fact a control operation of the `exn` effect.

Because the clause stands in for the result of the whole block, it must have the block's type. To tell "stopped"
apart from a real result, wrap the result:

```koka
fun try-pack(items : list<(string, int)>) : maybe<int>
  with final ctl too-heavy(_) Nothing
  Just(pack(items))
```

`final ctl` marks a clause that never resumes. It is not required, but it documents the intent, lets the
compiler skip capturing the resumption, and runs clean-up code eagerly.

The declared result type `a` of `too-heavy` is a type variable: an operation that never returns to its caller can
pretend to return a value of any type, which is why `too-heavy(name)` fits in the `else` branch of an `int`.

## Deciding per call

The clause is ordinary code, so it can resume on some calls and stop on others, depending on the arguments or on
what the clause finds out:

```koka
with ctl ask-weight(item)
  if item == "anvil" then 0 - 1 else resume(item.count)
```

## Code after `resume`

`resume(x)` is a function call that returns: its result is what the rest of the handled computation finally
produces, up to the end of the handled block. A clause can therefore look at that result and change it before
passing it on:

```koka
effect ctl note(text : string) : ()

fun with-footnotes(action : () -> <note|e> string) : e string
  with ctl note(text)
    val story = resume(())
    story ++ " [" ++ text ++ "]"
  action()

fun tale() : note string
  note("first")
  note("second")
  "The end."
```

`with-footnotes(tale)` is `"The end. [second] [first]"`: each clause waits for the rest of the story, so the
footnote of the later note is added first. When the handler's result is a tuple, a clause can take it apart with
`val (x, y) = resume(…)` and build a new one.

## `ctl` in declarations and handlers

Declaring an operation `ctl` allows its handlers any of this; declaring it `fun` restricts them to always
resuming once. A handler of a `ctl` operation may still use a `fun` clause when it simply returns a value. Like
`fun` clauses, `ctl` clauses can be marked `override` to call the operation they handle, which reaches the
handler further out.
