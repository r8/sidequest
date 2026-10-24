# About

## Reshape

`𝕨 ⥊ 𝕩` takes the elements of `⥊𝕩` in order and fills an array of shape `𝕨`, cycling through them if there
are too few. A number for `𝕨` makes a list: `5 ⥊ 1‿2` is `⟨ 1 2 1 2 1 ⟩`. Reshaping an empty array into a
non-empty shape is an error.

One entry of the shape can be left for BQN to compute, given the total number of elements:

| entry | meaning |
| --- | --- |
| `∘` | the length that uses every element exactly; an error if it does not divide evenly |
| `⌊` | round down: drop the elements that don't fill a whole cell |
| `⌽` | round up and fill the last cell from the start |
| `↑` | round up and fill the last cell with the fill element (0 or space) |

```bqn
∘‿3 ⥊ ↕6     # 0 1 2 / 3 4 5
⌊‿4 ⥊ ↕6     # 0 1 2 3
```

## Deshape

`⥊ 𝕩` is the list of the elements of `𝕩` in index order, whatever its rank. An atom becomes a one-element
list. Deshape followed by reshape, `(≢𝕩) ⥊ ⥊𝕩`, gives `𝕩` back, which makes `⥊` the usual way to apply a list
function to every element of an array and restore the shape afterwards.

## Transpose

`⍉ 𝕩` moves the first axis to the end. For a table it swaps rows and columns; for a list or atom it does
nothing. `⍉⁼ 𝕩` (undo transpose) moves the last axis to the front instead. With a left argument, `𝕨 ⍉ 𝕩` puts
each axis of `𝕩` at the position given in `𝕨`, which can reorder axes arbitrarily, and listing two axes at the
same position takes a diagonal:

```bqn
0‿0 ⍉ 3‿3 ⥊ ↕9    # ⟨ 0 4 8 ⟩, the main diagonal
```

## Related structural functions

Reversing (`⌽`), taking and dropping (`↑`, `↓`) and joining (`∾`, `≍`) work along the leading axis of arrays
of any rank, so the rows of a table can be reversed with `⌽` and its columns with `⌽˘` or `⌽⎉1`.
