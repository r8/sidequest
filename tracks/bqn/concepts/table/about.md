# About

## Table

`𝕨 F⌜ 𝕩` calls `F` on every element of `𝕨` paired with every element of `𝕩`, and arranges the results in an
array of shape `(≢𝕨) ∾ ≢𝕩`. For two lists this is a table with one row per element of `𝕨`. It is what APL
calls the outer product.

Table goes one level into its arguments, whatever their rank: the elements of a table argument are its
single values, not its rows. To pair up the _rows_ of two tables instead, use the rank modifier: `F⎉1‿∞`
calls `F` on each row of `𝕨` with the whole of `𝕩`.

## Monadic table

`F⌜ 𝕩` with one argument is the same as `F¨ 𝕩`: it calls `F` on each element.

## Idioms

| goal | expression |
| --- | --- |
| times table | `n ×⌜ n` with `n ← 1+↕10` |
| identity matrix of size `n` | `(↕n) =⌜ ↕n` |
| lower triangle | `(↕n) ≥⌜ ↕n` |
| every difference | `a -⌜ b` |
| all pairs as lists | `a ⋈⌜ b` |

Comparison tables are a common way to test every element against every other without a loop: `+´˘ a =⌜ b`
counts, for each element of `a`, how many times it occurs in `b`.

## Cost

A table of two lists of lengths `m` and `n` has `m × n` elements, so it is easy to build something very
large by accident. For searching, `⊐` and `∊` do the same job as `=⌜` without the quadratic table.
