# Introduction

A list is written `⟨1, 2, 3⟩`, or by _stranding_ single values with `‿`: `1‿2‿3`. The empty list is `⟨⟩`,
and a one-element list needs the brackets, `⟨3⟩`.

`≠ list` is its length, `↕ n` is the list `0‿1‿…‿(n-1)`, and `a ∾ b` joins two lists (a single number counts
as a list of one).

Arithmetic and comparisons apply to lists element by element, and a single number is used with every element:

```bqn
1‿2‿3 + 10        # ⟨11, 12, 13⟩
1‿2‿3 × 4‿5‿6     # ⟨4, 10, 18⟩
2‿8‿5 > 4         # ⟨0, 1, 1⟩
```

Two lists combined this way must have the same length, or BQN raises an error.
