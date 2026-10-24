# About

## Definition

For a list `l`, `` F` l `` has the same length as `l`. Its first element is `⊑l`, and each later element is
`r[i-1] F l[i]`, where `r` is the result itself. With a left argument, `` w F` l `` starts from `w`: the first
element is `w F l[0]`, and `w` itself is not part of the result.

The order is the opposite of fold's: fold groups to the right, `a F (b F c)`, while scan groups to the left,
`(a F b) F c`. For associative operands (`+ × ⌈ ⌊ ∧ ∨ ≠ =`) the difference does not matter, and the last element of
the scan equals the fold. For `-`, `÷` and blocks it does: in a block, `𝕨` is the accumulated state and `𝕩` the next
item, which is the natural way round for a state machine.

## Boolean idioms

- `` ∧` b `` keeps the leading run of `1`s: "still true".
- `` ∨` b `` turns on at the first `1`: "has happened".
- `` +` b `` numbers the `1`s: each position gets the count of `1`s up to it, which is useful for labelling
  groups, such as words in a string separated by spaces.
- `` ≠` b `` toggles at every `1`, marking the parts between pairs of delimiters, such as text inside quotes.
- `` +´ ¬ ∨` b `` is the number of elements before the first `1`.

## Arrays

On a table, scan works along the first axis: each row is combined with the result for the row above, giving
running totals down the columns. To scan along each row, use scan with the cells modifier, `` +`˘ ``, from a later
lesson.

## Edge cases

Scanning an empty list gives an empty list without calling the operand; the starting value, if given, is ignored.
Scanning an atom is an error. A left argument must have the shape of one cell of the argument: an atom for a list, a row for a
table. So `` 0‿0 +` 1‿2 `` is an error, while `` 0‿0 +` table `` starts each column's running total from `0`.
