# Introduction

An `either<a,b>` holds one of two things: a `Left` with an `a` or a `Right` with a `b`. By convention `Right` is
success and `Left` carries what went wrong, so a check that can fail for a reason returns an either:

```koka
fun check-age(age : int) : either<string,int>
  if age < 0 then Left("age cannot be negative") else Right(age)
```

Callers take it apart with `match`, one branch per constructor. To run several checks, match on the first and run
the next one only in its `Right` branch, handing a `Left` back as a new `Left`. `is-left`, `is-right` and
`.maybe` (which drops the message) are in the standard library, and eithers support `==` and `show` when both
sides do.
