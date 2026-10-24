# Introduction

The _cells_ of an array are its slices along the first axis: the rows of a table. `F˘` (cells) applies `F` to
each cell and collects the results:

```bqn
t ← > ⟨80‿65‿90, 70‿75‿60⟩
+´˘ t        # ⟨ 235 205 ⟩, the sum of each row
```

`F⎉r` (rank) applies `F` to the pieces of rank `r`: `⎉0` single values, `⎉1` rows, and negative numbers count
down from the whole array, so `F˘` is `F⎉¯1`. It is needed when a list should be combined with each row of a
table rather than matched against its rows: `t +⎉1 5‿0‿10` adds `5‿0‿10` to every row.
