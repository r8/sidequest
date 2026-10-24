# Introduction

A _fiber_ is a function that can pause and resume: a coroutine.
`fiber/new` wraps a function in a fiber without running it; `resume` runs it until it calls `yield` or returns, and returns that value.
The next `resume` continues right after the `yield`.

```janet
(def f (fiber/new (fn [] (yield 1) (yield 2) :done)))
(resume f) # => 1
(resume f) # => 2
(resume f) # => :done
```

`fiber/status` is `:new`, `:pending` (paused), `:alive` (running), `:dead` (returned) or `:error`; resuming a dead fiber is an error.
A value passed as `resume`'s second argument becomes the function's argument on the first resume and the value of `yield` afterwards.

Fibers are iterable: `each`, `map` and friends resume them and see every yielded value (not the final return value).
`(coro body…)` is shorthand for `(fiber/new (fn [] body…))`.
