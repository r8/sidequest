# Introduction

`bool` has two values, `True` and `False`. `&&` (and), `||` (or) and `!` (not) combine them; `&&` binds more
tightly than `||`, and both short-circuit, evaluating their right side only when it matters. Comparisons —
`==`, `!=`, `<`, `<=`, `>`, `>=` — produce booleans:

```koka
fun can-vote(age : int, registered : bool) : bool
  age >= 18 && registered
```

Comparisons do not chain: write `0 <= x && x < 10`, not `0 <= x < 10`.
