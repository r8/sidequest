# Introduction

## Arrays have a shape

So far every value has been a single number or a list. Lists are one kind of _array_: a collection of values
laid out along some number of _axes_. A list has one axis. A table has two, rows and columns. An array can have
three or more, and a single number has none.

The number of axes is the array's _rank_, and the length along each axis is its _shape_. `≢ 𝕩` returns the
shape as a list and `= 𝕩` returns the rank:

```bqn
≢ 1‿2‿3       # ⟨ 3 ⟩
= 1‿2‿3       # 1
≢ 5           # ⟨⟩: a number has no axes
= 5           # 0
```

`≠ 𝕩`, the length, is the length of the _first_ axis: for a table, the number of rows.

## Reshape

`𝕨 ⥊ 𝕩` (reshape) makes an array with shape `𝕨` out of the elements of `𝕩`, taken in order:

```bqn
t ← 2‿3 ⥊ 1‿2‿3‿4‿5‿6
t
# ┌─
# ╵ 1 2 3
#   4 5 6
#         ┘
≢ t           # ⟨ 2 3 ⟩
= t           # 2
≠ t           # 2: two rows
```

The elements fill the first row, then the second, and so on; with three axes they fill the first table, then
the next. The shape can be any length:

```bqn
≢ 3‿2‿6 ⥊ ↕36     # ⟨ 3 2 6 ⟩: three tables of 2 rows and 6 columns
```

If `𝕩` has more elements than needed, the rest are ignored; if it has fewer, it starts again from the
beginning. So reshape can also repeat a pattern:

```bqn
2‿3 ⥊ 1‿2         # 1 2 1 / 2 1 2
2‿2 ⥊ 7           # a 2-by-2 table of sevens
```

## Deshape

`⥊ 𝕩` with no left argument (deshape) does the opposite: it lists all the elements of `𝕩`, row after row,
as a plain list. `⥊ t` is `⟨ 1 2 3 4 5 6 ⟩`, and `≠ ⥊ 𝕩` counts the elements of an array of any rank.

## Transpose

`⍉ 𝕩` (transpose) turns rows into columns. For a table of shape `r‿c` the result has shape `c‿r`, and the
first row of the result is the first column of `𝕩`:

```bqn
⍉ 2‿3 ⥊ 1‿2‿3‿4‿5‿6
# ┌─
# ╵ 1 4
#   2 5
#   3 6
#       ┘
```

For higher ranks, `⍉` moves the first axis to the end: shape `3‿2‿6` becomes `2‿6‿3`.

## Arithmetic on arrays

Arithmetic and comparison work element by element on arrays of any rank, just as on lists. A number is
combined with every element, and two arrays of the same shape are combined position by position:

```bqn
(2‿3 ⥊ 1‿2‿3‿4‿5‿6) + 10      # 11 12 13 / 14 15 16
(2‿2 ⥊ 1‿2‿3‿4) × 2‿2 ⥊ 0‿1   # 0 2 / 0 4
```

## Pitfalls

- The shape comes first: `2‿6 ⥊ eggs`, not `eggs ⥊ 2‿6`.
- `≠` is the number of rows of a table, not the number of elements; use `≠ ⥊ 𝕩` for that.
- Reshaping an empty list to a non-empty shape is an error, since there is nothing to repeat.
- Reshape never complains about a wrong number of elements: it repeats or drops them. Check the length yourself
  when it matters.
