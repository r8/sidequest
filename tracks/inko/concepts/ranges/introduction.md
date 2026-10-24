# Introduction

`Int.until` and `Int.to` create ranges of integers: `0.until(3)` is 0, 1 and 2, and `1.to(3)` is 1, 2 and 3. They
are used for counting loops:

```inko
for index in 0.until(values.size) {
  …
}
```

`step_by(n)` counts in steps of `n`, `size` gives the number of values, and `contains?(n)` checks membership.
Ranges only count up: `5.to(1)` is empty. `Int.times(fn (i) { … })` runs a closure `n` times.
