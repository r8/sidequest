# Introduction

A type variable — a lower-case name such as `a` or `b` in a signature — stands for any type, which makes the
function _polymorphic_: one definition that works for many types.

```koka
fun swap(p : (a, b)) : (b, a)
  (p.snd, p.fst)
```

Each call chooses the types: `swap((1, "x"))` is a `(string, int)`. Types take parameters the same way:
`type crate<a> { Vacant; Holding(item : a) }` declares a crate of anything, as `list<a>` and `maybe<a>` are lists
and maybes of anything.

Because nothing is known about an `a`, a polymorphic function cannot compare, add or show one. When it needs to,
it takes the operation as a parameter, such as `same : (a, a) -> bool`, and the caller, who knows the type,
supplies it.
