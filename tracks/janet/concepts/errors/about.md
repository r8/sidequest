# About

## Raising

- `(error x)` raises an error whose value is `x`. Strings are conventional, but keywords and structs (`(error {:kind :jam :tray 2})`) let the catching code dispatch on the kind without parsing text.
- `(errorf fmt & args)` is `(error (string/format fmt ;args))`.
- `(assert x &opt message)` raises `message` (or a default naming the failed expression) when `x` is falsy, and returns `x` otherwise, so it can wrap an expression in place.

Janet's own errors — a wrong argument type, a bad index, calling `nil` — are raised the same way, with string messages.

## Catching

```janet
(try
  body
  ([err] handler))
```

`try` evaluates `body`; if it raises, `err` is bound to the error value and `handler` runs, and its value becomes the value of the `try`.
The handler can take a second binding, `([err fiber] …)`, for the fiber the error was raised in, which `debug/stacktrace` can print.
Errors that the handler does not want can be raised again with `(error err)`.

`(protect & body)` evaluates the body and returns `[true value]` or `[false error]`, never raising.
It is `try` for when the outcome should be data.

## Errors are fiber signals

Under the hood, `error` is a _signal_ of the current fiber, and `try` runs its body in a new fiber that catches the error signal.
That is why errors from any depth of calls are caught, and why the same machinery also implements generators and the event loop.
`(fiber/new f :e)` creates a fiber that catches errors itself, and `resume` returns the error value; `fiber/status` then reports `:error`.
A later lesson covers fibers.

## Clean-up

An error skips the rest of every function it unwinds through.
`defer` runs clean-up code however its body ends, `edefer` only when it ends with an error, and `with` combines acquiring a resource with closing it; a later lesson covers them.

## Style

- Raise errors for situations the caller cannot reasonably check in advance, or for misuse; return `nil` or a default for expected absence (`get` returns `nil` for a missing key rather than raising).
- Catch narrowly: test the error value and re-raise the rest, so bugs are not hidden.
- Give messages the data needed to find the problem: `no such slot: C7`, not just `bad slot`.
