# Introduction

`var` binds a name that `set` can change later; `++`, `--`, `+=`, `-=`, `*=` and `/=` update it in place.
A name made with `def` cannot be set.

Janet's basic loops:

```janet
(each x xs …)          # once per element of an array or tuple
(for i 0 n …)          # i = 0, 1, …, n - 1
(while condition …)    # as long as condition is truthy
```

`break` leaves the innermost loop.
Loops return `nil`, so a loop that computes something keeps the result in a `var`:

```janet
(var sum 0)
(each n [1 2 3] (+= sum n))
sum   # => 6
```
