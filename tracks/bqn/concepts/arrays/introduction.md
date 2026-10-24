# Introduction

Every BQN array has a number of axes, its _rank_, and a length along each, its _shape_. A list has rank 1, a
table rank 2, and a single number rank 0. `≢ 𝕩` gives the shape, `= 𝕩` the rank, and `≠ 𝕩` the length of the
first axis (the number of rows of a table):

```bqn
t ← 2‿3 ⥊ ↕6
≢ t     # ⟨ 2 3 ⟩
= t     # 2
≠ t     # 2
```

Arithmetic and comparison work element by element on arrays of any rank, combining a single number with every
element, or two arrays of the same shape position by position.
