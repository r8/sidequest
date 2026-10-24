# Introduction

## Several handlers, one computation

A computation can use several effects, and each needs a handler. Handlers nest: every `with` statement wraps
everything below it, so the first `with` is the outermost handler and the last one is closest to the code that
performs the operations.

```koka
effect abort
  ctl abort() : a

effect note
  fun note(s : string) : ()

fun keep-notes(action : () -> <note|e> a) : e (a, list<string>)
  var notes := []
  with handler
    return(x) (x, notes.reverse)
    fun note(s) notes := Cons(s, notes)
  action()

fun attempt(action : () -> <abort|e> a) : e maybe<a>
  with ctl abort() Nothing
  Just(action())

fun errand() : <abort,note> int
  note("left home")
  abort()
```

Each handler removes its own effect from the type and leaves the rest for the handlers outside it. The effect
variable `e` is what makes that work: `keep-notes` takes any action that uses `note` and whatever else (`e`), and
leaves the whatever else to someone further out.

## The order decides the meaning

Both orders of these two handlers type-check, and they mean different things:

```koka
attempt { keep-notes(errand) }   // Nothing
keep-notes { attempt(errand) }   // (Nothing, ["left home"])
```

In the first, `abort` is handled outside `keep-notes`. Not resuming throws away everything between the
operation and the handler, and that includes the `keep-notes` handler: its `return` clause never runs, and the
notes are lost. In the second, the abort only discards what is inside `attempt`; the notes survive, and
`keep-notes` pairs them with the `Nothing`.

The result types follow the nesting too: an inner handler's result is the value the outer handler sees as the
result of its action, which is why the two orders give `maybe<(int, list<string>)>` and
`(maybe<int>, list<string>)`.

## Handlers that resume more than once

The same question gets more interesting with a handler that resumes several times. A resumption captures
everything between the operation and its handler, so it matters which other handlers lie in that stretch:

- a state handler _inside_ a multi-shot handler is part of every resumption. Each resumption gets its own copy
  of the state as it was at the operation, so every path has its own state;
- a state handler _outside_ it is not captured: all paths share one state, and a change made in one path is
  still there when the next path runs.

Choose the order by asking which of the two you want.

## Handlers that use other effects

The body of an operation clause runs in the context of the handler, outside of it. If a clause performs an
operation itself, that operation goes to the handlers further out, so a handler can give one effect a meaning in
terms of another:

```koka
fun loud(action : () -> <note,console|e> a) : <console|e> a
  with fun note(s) println("note: " ++ s)
  action()
```

`loud` handles `note` by printing. Its result has the `console` effect that its clause uses, and the action's type
says that it may use `note` as well as everything the result has: a handler always takes an action whose effect
is the handled effect added to the handler's own effect.

## Pitfalls

- An operation is handled by the innermost handler of its effect. Two handlers of the same effect shadow each
  other; the inner one answers.
- When the order of two `with` statements looks arbitrary, check whether one of the handlers aborts or resumes
  more than once: those are the cases where the order changes the result.
- If the types do not line up, write the action's effect as the handled effects plus the result's effect,
  exactly as in `loud`.
