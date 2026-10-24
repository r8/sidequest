# Introduction

A computation that uses several effects runs under several handlers. Each `with` wraps everything below it, so
the first `with` is the outermost handler; each handler removes its own effect from the type and leaves the rest
to the handlers outside it.

The order matters whenever a handler does not resume exactly once:

- a handler that aborts (does not resume) discards every handler between the operation and itself, so state
  kept inside it is lost, while state kept outside it survives;
- a handler that resumes several times copies everything between the operation and itself into each
  resumption, so a state handler inside it gives every path its own state, and one outside it is shared by
  all the paths.

An operation clause runs outside its handler, so the operations it performs go to handlers further out: one
effect can be implemented in terms of another.
