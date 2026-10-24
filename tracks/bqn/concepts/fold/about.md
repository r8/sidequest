# About

## Order of evaluation

`F´ a‿b‿c‿d` is `a F (b F (c F d))`. The right-to-left order matches the rest of the language: `-´` gives an
alternating sum, and `÷´ a‿b‿c` is `a ÷ (b ÷ c)`. In a block operand, `𝕨` is the next element from the right and
`𝕩` everything folded so far. To fold from the left instead, reverse the list and swap the arguments, which a
later lesson's combinators make short.

## Identities

Folding an empty list returns the identity of the operand, if BQN knows one:

| operand | identity |
| --- | --- |
| `+` `-` `∨` `≠` | `0` |
| `×` `÷` `∧` `=` | `1` |
| `⌈` | `¯∞` |
| `⌊` | `∞` |

Otherwise it is an error. A list with a single element returns that element without calling the operand at all,
so a block's mistakes may not show until the list has two elements.

## The initial value

`init F´ list` is `l₀ F (l₁ F (… F (lₙ F init)))`: the initial value goes in at the right end. It is how to fold
a block over a possibly empty list, and how to accumulate into a value of a different kind than the elements,
such as building a list from numbers.

## Fold and insert

Fold works on lists only: it needs exactly one axis. To combine the rows of a table, BQN has a sibling modifier,
_insert_ `˝`, which reduces along the first axis of an array of any rank. `+˝ table` adds up the rows to give
column totals.

## Common folds

- `+´` sum, `×´` product, `⌈´` maximum, `⌊´` minimum.
- `∧´` all, `∨´` any, `+´ list = x` count matches.
- `≠´` parity of a boolean list: `1` when an odd number of elements are `1`.
- `∾´` joins a list of lists (the primitive `∾` with one argument does the same more directly).
