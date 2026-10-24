# About

## The full set

| Word | Stack effect | Standard |
| --- | --- | --- |
| `dup` | `( a -- a a )` | core |
| `?dup` | `( a -- a a \| 0 )` | core: duplicates only a non-zero item, see the conditionals concept |
| `drop` | `( a -- )` | core |
| `swap` | `( a b -- b a )` | core |
| `over` | `( a b -- a b a )` | core |
| `rot` | `( a b c -- b c a )` | core |
| `-rot` | `( a b c -- c a b )` | gforth (common, not standard) |
| `nip` | `( a b -- b )` | core extension |
| `tuck` | `( a b -- b a b )` | core extension |
| `pick` | `( xu … x0 u -- xu … x0 xu )` | core extension |
| `roll` | `( xu … x0 u -- xu-1 … x0 xu )` | core extension: moves rather than copies |
| `2dup 2drop 2swap 2over` | pairs | core |
| `2rot` | `( a b c d e f -- c d e f a b )` | double extension |
| `depth` | `( -- n )` | the number of items on the stack |

## Style

- Keep the number of live items small. Three is comfortable; past four, readers (and writers) lose track.
  Factor a long shuffle into a named word with a clear stack effect, or use the return stack (see that concept) to hold an item aside.
- `pick` and `roll` with a computed depth are a smell in ordinary code: they make the stack effect depend on run-time values.
- Choose the argument order of your own words so that callers rarely need to shuffle: put the argument that changes least deep, and the one that is computed last on top.
- Comment the stack after tricky steps, as `\ a b sum`.

## Common idioms

- `over + swap` turns `( addr len )` into `( end start )` — gforth names it `bounds`.
- `2dup <` compares while keeping both numbers.
- `swap -` subtracts the other way round: `( a b -- b-a )`.
- `dup *` squares; `tuck` before an operation keeps the top for afterwards.
