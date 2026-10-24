# Introduction

A modifier takes operands (functions or values written next to it) and returns a new function, or any other
value. You write one as a block that mentions an operand:

- `𝔽` / `𝕗`: the left operand, used as a function / as a subject;
- `𝔾` / `𝕘`: the right operand, which makes the block a 2-modifier.

A 1-modifier's name starts with `_`, a 2-modifier's starts and ends with `_`:

```bqn
_twice ← {𝔽 𝔽 𝕩}
-⟜3 _twice 10          # 4
_after_ ← {𝔽 𝔾 𝕩}
-⟜1 _after_ (2⊸×) 5    # 9
```

Modifiers bind before functions are called and group from left to right, so a composed right operand needs
parentheses.
