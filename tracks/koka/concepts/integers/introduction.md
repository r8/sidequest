# Introduction

Koka's `int` is a whole number of any size: it never overflows. Besides `+`, `-` and `*` it has `/` and `%`,
which use Euclidean division — the quotient rounds down and the remainder is never negative for a positive
divisor:

```koka
17 / 5     // 3
-17 / 5    // -4
-17 % 5    // 3
```

Dividing by zero gives `0` (and `x % 0` is `x`) instead of an error. `divmod`, `abs`, `min`, `max` and `pow`
(`^`) cover the rest of everyday integer arithmetic. A negative literal is `-5`, but a name is negated with
`~x`: `-x` is a syntax error.
