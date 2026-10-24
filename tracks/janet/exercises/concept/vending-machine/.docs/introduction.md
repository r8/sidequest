# Introduction

Some problems cannot be answered with a value: a slot that does not exist, a coin the machine does not take, a division the input makes impossible.
Instead of returning a special value that every caller must remember to check, a function can _raise an error_.
The error stops the function, and the function that called it, and so on, until some code that is prepared for it _catches_ it — or, if nothing does, the program stops and prints the error.

## Raising errors

`error` raises an error with a value, usually a message string:

```janet
(defn check-age
  "(check-age age) -> age; errors when age is negative"
  [age]
  (when (< age 0)
    (error "age cannot be negative"))
  age)

(check-age 30)  # => 30
(check-age -1)  # error: age cannot be negative
```

Nothing after the `error` runs.
`errorf` formats the message first, with the same directives as `string/format`:

```janet
(errorf "no room %d on floor %d" 12 3) # error: no room 12 on floor 3
```

The value of an error does not have to be a string.
A keyword or a struct lets the catching code tell kinds of errors apart without parsing a message: `(error :out-of-paper)`, `(error {:kind :jam :tray 2})`.

## `assert`

`assert` checks that a condition holds and raises an error with the given message when it does not.
When the condition holds, `assert` returns its value:

```janet
(assert (> amount 0) "amount must be positive")
```

It is the shortest way to state what a function expects of its arguments.

## Catching errors with `try`

`try` runs an expression and, if it raises an error, runs a _handler_ instead.
The handler is written after the expression as `([err] …)`, where `err` is bound to the error's value:

```janet
(try
  (check-age -1)
  ([err] (string "rejected: " err)))
# => "rejected: age cannot be negative"

(try
  (check-age 30)
  ([err] (string "rejected: " err)))
# => 30, no error so the handler does not run
```

The value of the whole `try` is the value of the expression, or of the handler when there was an error.
Errors raised anywhere inside the expression are caught, however deep in other function calls they started, including errors from Janet itself, such as adding `nil` to a number.

## Raising it again

A handler does not have to deal with every error.
It can look at the value and raise it again with `error` for errors that are someone else's problem:

```janet
(try
  (print-ticket printer)
  ([err]
    (if (= err :out-of-paper)
      (refill printer)
      (error err))))
```

The error then continues outwards, to the next `try` around this one.

## `protect`

`protect` is a shorthand that never raises: it runs its body and returns a tuple of whether it succeeded and either the result or the error value:

```janet
(protect (check-age 30))  # => (true 30)
(protect (check-age -1))  # => (false "age cannot be negative")
```

This is convenient when the result and the failure are handled the same way, or passed on as data.

## Pitfalls

- A handler that swallows every error also swallows your bugs, such as a typo that adds `nil` to a number. Catch the errors you expect, and raise the others again.
- The message a caller sees is exactly the value you passed to `error`, so callers that compare messages depend on their exact wording.
- Code after an `error` in the same function never runs, so any clean-up placed there is skipped. A later lesson shows `defer`, which runs clean-up whatever happens.
