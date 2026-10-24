# Introduction

`throw(message)` stops a function with an exception, and gives it the `exn` effect. `try` catches it:

```koka
fun withdraw(balance : int, amount : int) : exn int
  if amount > balance then throw("insufficient funds") else balance - amount

try({ withdraw(10, 30) })                 // an error<int>: Ok(value) or Error(exception)
try({ withdraw(10, 30) }).maybe           // Nothing
try({ withdraw(10, 30) }).default(0)      // 0
try(fn(err) 0) { withdraw(10, 30) }       // 0, from the handler
```

Match an `error<a>` on `Ok(x)` and `Error(err)`; `err.message` is the text. Write `match try({ … })` with the
parentheses. A function that catches every exception it can cause loses the `exn` effect: catching is handling
the effect.
