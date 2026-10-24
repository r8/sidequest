# About

## Resumptions are first-class

The `resume` bound in a `ctl` clause is a function from the operation's result type to the handler's result
type. A clause may call it zero times (abort the path), once (an ordinary operation), or many times (explore
several answers), and it may do work before and after each call:

```koka
ctl toss() resume(True) ++ resume(False)             // all answers
ctl toss() max(resume(True), resume(False))          // the best answer
ctl toss()                                           // the first answer that works
  val heads = resume(True)
  if heads.is-empty then resume(False) else heads
```

The type of every resumption's result is the handler's result type, which is why a `return` clause is usually
needed: `return(x) [x]` turns one finished run into a list so that the runs can be appended, `return(_) 1`
counts them, `return(x) Just(x)` marks success.

## Nondeterminism and search

The classic uses are nondeterminism and backtracking. A `choose`-style operation (`flip`, `pick-digit`) answered
in every way enumerates a search space; a `fail`-style operation whose type is `a` and whose clause does not
resume prunes it:

```koka
effect nondet
  ctl flip() : bool
  ctl fail() : a
```

The same program can be run under different handlers: all solutions, the first solution, the number of
solutions, or a random choice (with `fun flip() random-bool()`), without changing the program.

## What gets repeated

A resumption captures the computation from the operation to the end of the handler. Each call to `resume` runs
that part again, so its cost multiplies with the number of choices. Code before the operation is not repeated.

Local state behaves as follows:

- a `var` declared inside the handled computation belongs to that computation, so each resumption continues with
  the value it had when the operation was performed;
- a `var` declared outside the handler, in the enclosing function, is shared by all the runs: changes made in
  one path are visible in the next.

Where state sits relative to a multi-shot handler is the subject of combining handlers (the order of `with`
statements decides whether state is per path or global).

## `ctl`, `fun` and `final ctl`

Only `ctl` clauses can resume more than once. `fun` clauses resume exactly once, implicitly, and `final ctl`
clauses never resume. Declaring an operation `ctl` in the effect allows handlers to use any of the three; declaring
it `fun` restricts every handler to resuming once.

## Pitfalls

- An operation that resumes in several ways can make the search space huge; resume lazily (look at a result
  before resuming again) when only one solution is needed.
- Resources such as files do not mix well with multiple resumptions: the same continuation may run twice.
