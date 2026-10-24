# About

## Insert and fold

`F´ 𝕩` combines the elements of a list; `F˝ 𝕩` combines the major cells of an array of any rank. For a table,
`+˝` is `row0 + row1 + …`, evaluated from the right: `-˝` on the rows `a`, `b`, `c` is `a - (b - c)`. Insert
always works on whole cells, so its result is one cell: a list for a table, a table for a rank-3 array.

On a list the cells are single values wrapped as rank-0 arrays, so `+˝ 1‿2‿3` is a rank-0 array containing `6`;
`+´` gives the plain number.

## Empty arrays and initial values

`F˝` on an array with no cells returns an identity element shaped like a cell, when `F` has one:
`+˝ 0‿3 ⥊ 0` is `⟨ 0 0 0 ⟩`, and `⌈˝` gives `¯∞`s. A left argument is an initial value, combined at the right
end: `𝕨 F˝ 𝕩` is `c0 F c1 F … F 𝕨`. It must have the shape of a cell, or be a single value to combine with each
element of the cell.

## Columns and rows

For a table with one row per record and one column per field:

| expression | meaning |
| --- | --- |
| `+˝ t` | total of each column |
| `+´˘ t` | total of each row |
| `∧˝ t` | columns that are all 1 |
| `∨˝ t` | columns that have some 1 |
| `+˝⍉ t` | total of each row, by transposing first |

Insert also reduces a list of lists when they are merged into a table first: `+˝ > lists` adds lists of equal
length element by element.
