# About

## Pick

`i ⊑ x` returns one element of `x`. For a list, `i` is a number; for a table or higher-rank array, it is a list
with one index per axis: `1‿2 ⊑ table` is the element in row 1, column 2. Negative indices count back from the end
of each axis. Monadic `⊑ x` is the first element, an error if `x` is empty.

`⊑` also takes a list of index lists and picks each of them: `⟨0‿0, 1‿1⟩ ⊑ table` returns two elements. Because
of this, a list of numbers on the left of `⊑` is always one index into a multi-axis array, never several indices
into a list; use `⊏` for that.

## Select

`i ⊏ x` selects _major cells_ of `x`: for a list these are its elements, for a table its rows. The shape of the
result is the shape of `i` followed by the shape of a cell:

- a list of indices on a list gives a list (`2‿0 ⊏ "abc"` is `"ca"`),
- a single index gives a rank-0 array holding the element (`1 ⊏ "abc"` is not `'b'` but an enclosed `'b'`),
- a list of indices on a table gives a table of the chosen rows,
- a table of indices gives a table (`(2‿2⥊0‿1‿1‿0) ⊏ "ab"` is a 2×2 table of characters).

`⟨rows, cols⟩ ⊏ table` selects along both axes at once, giving the sub-table of those rows and columns. Monadic
`⊏ x` is the first major cell, `0 ⊏ x`.

## Idioms

- `(≠l) | i` wraps an index into range for circular access.
- `(n + ↕k) ⊏ l` is `k` consecutive elements from `n`; `n ↓ l` and `k ↑ l` express the same slice when it
  starts at an end.
- `i ⊏ lookup` translates a list of codes into values in one step: `digits ⊏ "0123456789"` turns digit values
  into characters.
- `l ⊏˜ i`, written with the swap modifier from a later lesson, puts the list being indexed first.

## Errors

Out-of-range indices are errors in both functions, and so are indices that are not whole numbers. There is no
"default value" for a missing index; check the range first, or extend the list with a default: `i ⊑ l ∾ default`.
