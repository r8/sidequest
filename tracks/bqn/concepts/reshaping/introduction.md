# Introduction

`𝕨 ⥊ 𝕩` (reshape) arranges the elements of `𝕩`, in order, into an array of shape `𝕨`. Elements are
repeated from the start if there are too few and dropped if there are too many:

```bqn
2‿3 ⥊ 1‿2‿3‿4‿5‿6    # 1 2 3 / 4 5 6
2‿3 ⥊ 1‿2             # 1 2 1 / 2 1 2
```

`⥊ 𝕩` (deshape) lists all the elements of `𝕩` in order. `⍉ 𝕩` (transpose) turns the rows of a table into
columns: shape `r‿c` becomes `c‿r`, and for higher ranks the first axis moves to the end.
