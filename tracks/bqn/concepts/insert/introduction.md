# Introduction

`F˝` (insert) places `F` between the major cells of an array, the rows of a table, and evaluates from the
right like fold. Arithmetic on rows is element by element, so the result has one value per column:

```bqn
t ← > ⟨80‿65‿90, 70‿75‿60⟩
+˝ t         # ⟨ 150 140 150 ⟩
⌈˝ t         # ⟨ 80 75 90 ⟩
```

A left argument is an initial value, as with fold. Use `´` for the elements of a list and `˝` for the rows of a
table: `+´` on a table is an error, and `+˝` on a list returns its sum wrapped in a rank-0 array.
