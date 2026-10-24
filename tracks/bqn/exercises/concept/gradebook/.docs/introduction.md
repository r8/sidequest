# Introduction

Fold, `F´`, works on lists. Given a table it is an error, because it does not know whether you mean the rows
or the columns:

```bqn
grades ← > ⟨80‿65‿90, 70‿75‿60, 95‿85‿100⟩   # a row per student
+´ grades      # Error: 𝔽´𝕩: 𝕩 must be a list
```

This lesson is about saying which: applying a function to each row with _cells_ and _rank_, and combining the
rows with _insert_.

## Cells

The _cells_ of a table are its rows. (Of any array, they are the slices along its first axis: the elements of a
list, the tables of a rank-3 array.) The 1-modifier `˘` (cells) applies its operand to each cell separately and
collects the results:

```bqn
+´˘ grades     # ⟨ 235 205 280 ⟩: the sum of each row
⌈´˘ grades     # ⟨ 90 75 100 ⟩: the largest of each row
```

Read `+´˘` as "(sum) on each row": `˘` applies to the whole function to its left, `+´`. The operand can be any
function, including a block, which then gets one row as `𝕩`:

```bqn
{(+´ 𝕩) ÷ ≠𝕩}˘ grades
```

When each call returns a single value, the result is a list with one value per row. When each call returns a
list of the same length, the results are put back together as rows of a new table.

## Insert

`˝` (insert) is fold for the rows of a table: `+˝ grades` places `+` between the rows, `row0 + row1 + row2`.
Adding rows adds them element by element, so the result is one total per _column_:

```bqn
+˝ grades      # ⟨ 245 225 250 ⟩
⌈˝ grades      # ⟨ 95 85 100 ⟩: the largest of each column
```

So for a table with one row per student and one column per assignment, `+´˘` totals each student and `+˝`
totals each assignment.

Like fold, insert works from the right, and it takes an optional initial value on the left, which matters for
a table with no rows:

```bqn
+˝ 0‿3 ⥊ 0     # ⟨ 0 0 0 ⟩
```

Insert on a plain list combines its elements as fold does, but the result is wrapped as an array with no axes;
use `´` for lists and `˝` for tables.

## Rank

Arithmetic between a table and a list matches the list against the table's _rows_: the first number goes with
the whole first row, the second with the second row, and so on. That is right when the list has one number
per student:

```bqn
grades + 1‿2‿3       # 1 is added to the first row, 2 to the second, 3 to the third
```

When the list has one number per _column_ instead, the function has to be applied to each row of the table
with the whole list. The 2-modifier `⎉` (rank) does this: `F⎉1` applies `F` to the rank-1 pieces, the rows, of
its arguments. A list is already rank 1, so it is used whole each time:

```bqn
grades +⎉1 5‿0‿10    # 5 added to the first column, 10 to the third
```

`F˘` is the same as `F⎉¯1`: cells are the pieces one rank lower than the whole array. `⎉` lets you name any
rank, counting up from single values (`⎉0` is element by element, `⎉1` is rows) or down from the whole array
(`⎉¯1`).

## Pitfalls

- `˘` and `˝` attach to the whole function on their left: `+´˘` is `(+´)˘`, and `{…}˘` applies the block.
- Results of `F˘` must all have the same shape to form a table.
- `𝕨 + 𝕩` with a table and a list adds by rows; for columns use `⎉1`.
