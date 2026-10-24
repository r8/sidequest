# About

## The array model

A BQN array is a shape (a list of natural numbers) and a list of elements, one per position, in row-major
order: the last axis varies fastest. The number of elements is the product of the shape, `×´≢𝕩`. Any value
that is not an array (a number, character, function, modifier or namespace) is an _atom_, with shape `⟨⟩` and
rank 0. An array of rank 0 holding one element is a _unit_; it has the same shape as an atom but is not the
same thing, as nesting shows.

## Measuring

- `≢ 𝕩` shape, `= 𝕩` rank, `≠ 𝕩` length: `≠ 𝕩` is `⊑ ≢ 𝕩` for an array of rank at least 1, and 1 for an atom.
- `≠ ⥊ 𝕩` or `×´ ≢ 𝕩` is the number of elements.
- An array may have length 0 along an axis: `0‿3 ⥊ 0` is a table with no rows but three columns.

## Major cells and the leading axis

BQN treats the first axis specially. The _major cells_ of an array are its slices along the first axis: the
elements of a list, the rows of a table, the tables of a rank-3 array. Many primitives work on major cells:
`≠` counts them, `⊏` selects them, `∾` joins along the first axis, `∧` sorts them. Thinking of a table as a list
of rows makes most functions you know from lists work on tables too.

## Arithmetic and agreement

Arithmetic is pervasive: it applies element by element through arrays. Two arrays of different rank are
combined by matching leading axes, so a list with one number per row combines with each row:

```bqn
(2‿3 ⥊ ↕6) + 100‿200    # 100 101 102 / 203 204 205
```

The shapes must agree on the leading axes, otherwise it is a length error.

## Display

The REPL and `•Show` draw arrays of rank 2 or more in a box whose left edge marks the rank: `╵` for a table,
`╎` for rank 3. Rank 3 arrays are shown as tables separated by blank lines.
