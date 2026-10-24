# Introduction

A `ctl` operation hands control to its handler. The clause gets a `resume` function: calling `resume(x)` continues
the computation where the operation was called, as if it had returned `x`; not calling it abandons the rest of
the computation, and the clause's value becomes the result of the whole handled block.

```koka
effect ctl too-heavy(item : string) : a

fun try-pack(items : list<(string, int)>) : maybe<int>
  with final ctl too-heavy(_) Nothing      // never resumes
  Just(pack(items))
```

`final ctl` marks a clause that never resumes. An operation that never returns can have the result type `a`.
`resume` returns the final result of the handled block, so a clause can change it afterwards:
`val story = resume(()); story ++ " [note]"`.
