# About

## The problem

Cleanup that must happen "no matter what" is easy to get wrong with `try`: you have to catch the error, clean up, and re-raise it with its original fiber so the stack trace survives, and you must remember the success path too.
`defer`, `edefer` and `with` package that pattern.
They are macros built on fibers: the body runs in a fiber that traps errors (`:ti`), the cleanup runs, and if the body did not finish normally its signal is passed on with `propagate`, which keeps the original stack trace.

## `defer`

```janet
(defer (release lock)
  (do-work))
```

- The cleanup expression comes first so it sits next to the acquisition it pairs with.
- The value of the form is the body's value; the cleanup's value is discarded.
- An error in the body is re-raised after the cleanup. `defer` never handles errors; wrap it in `try` or `protect` for that.
- An error raised by the cleanup replaces the body's error.

## `edefer`

`edefer` runs the cleanup only when the body does not complete normally.
It is the tool for keeping data consistent across a multi-step change: make the change, then `edefer` its undo around the steps that might fail.

## `with`

```janet
(with [name constructor]          body…) # closes with (:close name)
(with [name constructor closer]   body…) # closes with (closer name)
```

- Files (`file/open`), sockets and streams (`net/connect`, `os/open`) and processes (`os/spawn`) all have a `:close` method, so `with` is the usual way to use them.
- Any table or struct with a `:close` function works too, including one that inherits it from a prototype.
- The closer runs exactly once, after the body, on success and on error.
- `with` binds the name with `def`, so the body cannot rebind it.

Nesting `with` forms closes resources in reverse order of opening, as you would by hand.

## Related macros

- `with-dyns` sets dynamic bindings for the length of a body and restores them afterwards.
- `with-vars` temporarily sets `var`s and restores their old values afterwards, even on error.
- `try` and `protect` handle errors rather than just reacting to them.

## Pitfalls

- The cleanup runs after the body's value is computed: returning a lazily consumed fiber that reads from a closed file, for example, fails later.
- A cleanup that can itself fail hides the original error. Keep cleanups to one simple action.
- `yield` inside the body of `defer`, `edefer` or `with` passes out of their fiber as usual (only errors and user signals 0–4 are trapped), so they work inside generators.
