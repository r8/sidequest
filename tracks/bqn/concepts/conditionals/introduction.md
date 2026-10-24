# Introduction

A block can have several bodies separated by `;`. BQN runs the first body whose header matches the arguments
and whose predicates hold. A predicate is a statement followed by `?`; it must be `1` or `0`, and `0` moves on to
the next body:

```bqn
Sign ← {𝕩 < 0 ? ¯1 ; 𝕩 > 0 ? 1 ; 0}
Name ← {𝕊 0: "zero" ; 𝕊 n: "some"}
Scale ← {𝕊 𝕩: 10 × 𝕩 ; 𝕨 𝕊 𝕩: 𝕨 × 𝕩}
```

Headers with literals choose by value, and `𝕊 𝕩:` versus `𝕨 𝕊 𝕩:` choose by the number of arguments. Only
the chosen body runs. Each body has its own local names, so names from one body's header are not visible in
the next; if no body matches, the call fails with "No header matched argument".
