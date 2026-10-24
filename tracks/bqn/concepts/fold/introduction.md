# Introduction

_Fold_ `´` is a 1-modifier that puts its operand between the elements of a list and evaluates the result, from
right to left like any BQN expression:

```bqn
+´ 1‿2‿3‿4     # 10
⌈´ 3‿9‿2       # 9
∧´ 1‿1‿0       # 0: not all true
-´ 1‿2‿3‿4     # ¯2, which is 1 - (2 - (3 - 4))
```

On an empty list, a fold returns its operand's identity: `+´ ⟨⟩` is `0`, `×´ ⟨⟩` is `1`, `⌈´ ⟨⟩` is `¯∞`. A block
has none, so folding one over an empty list is an error. A left argument gives the fold a starting value, which
is combined first, at the right end: `10 +´ 1‿2‿3` is `16`.
