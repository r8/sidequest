# Introduction

`error` raises an error with any value, usually a message; `errorf` formats the message like `string/format`.
`assert` raises an error with a message when its condition is false, and returns the condition's value otherwise.

```janet
(error "no such slot")
(errorf "no such slot: %s" code)
(assert (> amount 0) "amount must be positive")
```

An error unwinds the calls until a `try` catches it:

```janet
(try
  (risky)
  ([err] (string "failed: " err)))
```

The handler's `err` is the error value; the handler can raise it again with `(error err)` for errors it does not handle.
`protect` never raises: `(protect (risky))` is `[true result]` or `[false error-value]`.
