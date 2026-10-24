# Introduction

`Bool` has the values `true` and `false`. Comparisons (`==`, `!=`, `<`, `<=`, `>`, `>=`) produce booleans, `and`
and `or` combine them (short-circuiting), and `!` negates one:

```inko
(hour >= 9) and (hour < 17)
!finished or retry
```

A method answering a yes-or-no question returns a `Bool` and conventionally ends in `?`, such as `adult?`. Inko has
no truthiness: only a `Bool` can be a condition.
