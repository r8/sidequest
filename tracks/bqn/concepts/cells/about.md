# About

## Cells

`F˘ 𝕩` calls `F` on each major cell of `𝕩` (each row of a table, each table of a rank-3 array) and merges the
results into one array, whose cells are the results. The results must therefore all have the same shape. With
two arguments, `𝕨 F˘ 𝕩` pairs up the cells of `𝕨` and `𝕩`, which need the same length.

Common uses on a table:

| expression | meaning |
| --- | --- |
| `+´˘ t` | sum of each row |
| `⌽˘ t` | each row reversed |
| `⊑˘ t` | first column |
| `<˘ t` | a list of the rows, each as its own list |
| `(+´÷≠)˘ t` | mean of each row |

## Rank

`F⎉r` applies `F` to the cells of rank `r`, then merges the results. A non-negative `r` is the rank of the
pieces: `⎉0` is element by element, `⎉1` is each row of a table (or each list in a rank-3 array). A negative
`r` counts down from the argument's rank: `⎉¯1` is the major cells, the same as `˘`. An argument whose rank is
already at most `r` is used whole.

With two arguments, `r` can be a pair: `F⎉1‿0` uses rows of `𝕨` and single values of `𝕩`. A pair `𝕨r‿𝕩r` is
how you say exactly what goes with what. For example, `𝕨 +⎉1 𝕩` with a table `𝕨` and a list `𝕩` adds the list
to each row, while `𝕨 + 𝕩` adds each element of `𝕩` to a whole row of `𝕨`, because arithmetic matches leading
axes.

## Leading axis agreement

BQN's arithmetic works by leading axis agreement: when the shapes differ in rank, the shorter shape must be a
prefix of the longer one, and each element of the lower-rank argument combines with a whole cell of the other.
A list with one number per row combines with a table directly; a list with one number per column needs `⎉1` (or
transposing the table). This is a deliberate design: most primitives treat the first axis as the one that
matters, and rank changes which axis is first.

## Rank and other modifiers

Rank is the general tool; cells, `˘`, is shorthand for its most common use. Each `¨` is close to `⎉0`, but it
passes each element itself rather than a rank-0 array holding it, and it does not merge the results into one
array.
