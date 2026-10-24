# Introduction

A block `{…}` holds statements separated by newlines or `⋄`; its result is the value of the last one. Names
defined inside with `←` are local to each call, and the block can read the names around it.

`↩` changes an existing name, and `name F↩ x` is short for `name ↩ name F x`: `total +↩ 5`.

A header before a colon shows how the function is called and names its arguments, taking lists apart where a
strand of names stands in for one:

```bqn
Fare ← {zones 𝕊 adults‿children:
  adult ← 2 + 1.5 × zones
  (adults × adult) + children × adult ÷ 2
}
```

A block that mentions none of `𝕩`, `𝕨` or `𝕊` runs immediately instead of being a function; `{𝕊: …}` is a
function that ignores its argument.
