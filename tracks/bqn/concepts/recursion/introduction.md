# Introduction

Inside a function block, `𝕊` is the function itself, so a block can call itself on a smaller problem. A
recursive function needs a base case that answers directly and a recursive case that moves towards it; header
patterns and predicates express both:

```bqn
Factorial ← {𝕩 ≤ 1 ? 1 ; 𝕩 × 𝕊 𝕩 - 1}
SumTo ← {𝕊 0: 0 ; 𝕊 n: n + 𝕊 n - 1}
```

An accumulator carries a running result on the left: the one-argument body starts it, and the two-argument
bodies update it and return it at the end.

```bqn
Halvings ← {𝕊 n: 0 𝕊 n ; k 𝕊 1: k ; k 𝕊 n: (k + 1) 𝕊 ⌊ n ÷ 2}
```

There is no tail-call optimisation, and CBQN overflows the stack after a few thousand nested calls.
