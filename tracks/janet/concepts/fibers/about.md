# About

## What a fiber is

A fiber is a function together with its own call stack.
When it calls `yield`, the whole stack is suspended, so a fiber can pause from inside any number of nested calls and later continue exactly there.
Fibers are cheap — creating thousands is normal — and they are values: stored in tables, passed to functions, resumed by whoever holds them.

## The protocol

- `(fiber/new f &opt sigmask)` creates a fiber that will call `f`. `f` takes zero or one argument.
- `(resume fiber &opt x)` runs it. On the first resume, `x` is passed to `f`; on later ones, `x` is the value of the `yield` the fiber is paused at. `resume` returns the yielded value, or the function's return value when it finishes.
- `(yield &opt x)` pauses the current fiber and hands `x` to the `resume` that ran it.
- `(fiber/status fiber)` is one of `:new`, `:pending`, `:alive`, `:dead`, `:error`, `:debug`, `:interrupted`, `:suspended` (waiting for the event loop) or `:user0`…`:user7`.
- `(fiber/current)` is the running fiber, and `(fiber/last-value fiber)` the last value it yielded or returned.

Resuming a fiber whose status is `:dead` or `:error` raises an error.

## Fibers as generators

Because `each`, `map`, `filter`, `seq` and `loop`'s `:in` all accept fibers, a fiber is Janet's lazy sequence.
Iteration resumes the fiber until it is dead and uses every yielded value; the final return value is dropped.
An infinite generator is fine as long as the consumer stops: `take` with a count works on fibers.

```janet
(def naturals (coro (var n 0) (forever (yield (++ n)))))
(take 3 naturals) # => @[1 2 3]
```

`coro` is `(fiber/new (fn [] …))`; `generate` takes `loop`-style bindings and yields the body's value for each, like `seq` but lazily:

```janet
(def squares (generate [x :range [0 100]] (* x x)))
```

## Signals and error handling

Yielding is one of several _signals_ a fiber can raise; an error is another.
The optional `sigmask` of `fiber/new` says which signals the fiber traps instead of passing them to its parent.
`(fiber/new f :e)` catches errors: resuming it returns the error value and leaves the fiber in status `:error`.
That is how `try` and `protect` are built:

```janet
(def risky (fiber/new (fn [] (error "boom")) :e))
(resume risky)        # => "boom"
(fiber/status risky)  # => :error
```

`:y` traps yields (the default mask), `:t` errors and user signals 0–4, `:0`…`:9` single user signals, `:a` everything.

## Fibers carry context

A fiber has an environment table, which holds its dynamic bindings (`dyn`, `setdyn`).
`fiber/new` without flags starts with none of its creator's; the `:i` flag shares the creator's table, and `:p` gives it a fresh table whose prototype is the creator's, so it reads the creator's bindings but its own `setdyn` stays local.
`coro`, `generate` and `ev/go` inherit the creator's environment.
Janet's event loop (`ev/`) schedules fibers too: `ev/go` runs a fiber as a task that is resumed when its I/O or channel operation is ready.

## Pitfalls

- A `yield` reached outside any fiber you created propagates to the top level and stops the script.
- After the last `yield`, one more `resume` finishes the function; until then the fiber is `:pending`, not `:dead`.
- A fiber is mutable shared state: iterating it consumes it, for every holder.
