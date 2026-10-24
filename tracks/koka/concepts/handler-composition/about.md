# About

## Nesting

Handlers form a stack at runtime. An operation is handled by the innermost handler of its effect; everything
between the operation and that handler is the _resumption_ the clause receives. With `with` statements the first
one is the outermost:

```koka
with attempt          // outermost: handles abort
with keep-notes       // handles note
errand()              // uses both
```

Types follow the same nesting. A handler function has the shape

```koka
fun h(action : () -> <eff|e> a) : e b
```

it takes an action that may use `eff` plus anything in `e`, and leaves `e` to the outer handlers. Its result
`b` (often a transformed `a`, through a `return` clause) is what the next handler out sees as its action's
result.

## When the order matters

For handlers that resume exactly once (`fun` and `val` clauses), the order rarely changes the result. It does
when a handler aborts or resumes more than once, because then the part of the stack between the operation and
the handler is dropped or duplicated:

| Handler of the choice | state handler inside it | state handler outside it |
|---|---|---|
| aborts (`abort`, exceptions) | state discarded with the aborted part | state kept |
| resumes many times (`flip`) | each path has its own copy (local state) | one state shared by all paths (global state) |

The classic illustration is a search with a counter: with the counter inside the search, each solution reports
the work done along its own path; with it outside, the counter totals the work of the whole search. Koka's
`samples/handlers/scoped.kk` shows both.

A `var` behaves like a state handler at the place where it is declared: one declared inside the handled
computation is copied into each resumption, one declared in the function that installs the handler is shared.

## Handlers in terms of other effects

An operation clause runs in the context of the handler, not of the operation, so effects it performs are
handled further out. A handler can therefore translate one effect into another (`note` into `console`, a
`branch` into a decision based on `luck`), and its result type carries the effects its clauses use.

The action passed to such a handler must allow the effects of the handler's result as well:

```koka
fun loud(action : () -> <note,console|e> a) : <console|e> a
  with fun note(s) println("note: " ++ s)
  action()
```

## Handling an effect with itself

A handler may also forward to an outer handler of the same effect, to decorate it. The action then has the
effect twice, once for each handler:

```koka
fun numbered(action : () -> <note,note|e> a) : <note|e> a
  var n := 0
  with fun note(s)
    n := n + 1
    note(n.show ++ ". " ++ s)
  action()
```

The `note` inside the clause goes to the next `note` handler out. Koka also has `mask<eff>` to make an operation
skip the innermost handler of its effect, and `override` handlers for the same purpose.
