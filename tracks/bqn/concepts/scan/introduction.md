# Introduction

_Scan_ `` ` `` is a 1-modifier that returns every intermediate result of combining a list's elements, from the
left. The result is as long as the list:

```bqn
+` 5‿¯2‿10       # ⟨5, 3, 13⟩: running totals
⌈` 3‿1‿4‿1       # ⟨3, 3, 4, 4⟩: the largest so far
∧` 1‿1‿0‿1       # ⟨1, 1, 0, 0⟩: 1 until the first 0
∨` 0‿0‿1‿0       # ⟨0, 0, 1, 1⟩: 1 from the first 1 on
```

Each element is the previous result (`𝕨`) combined with the next element (`𝕩`), so `` -` 1‿2‿3 `` is
`⟨1, ¯1, ¯4⟩`. A left argument is a starting value: `` 100 +` 5‿¯2 `` is `⟨105, 103⟩`.
