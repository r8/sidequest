# About

## Replicate

`counts / list` returns the elements of `list`, in order, each repeated `counts[i]` times. Counts must be whole
numbers that are not negative; `¯1` is an error. A single number applies to every element (`3 / "ab"` is
`"aaabbb"`). Otherwise the lengths must match.

Filtering with a mask is the most common use, and the mask is usually computed from the list itself:
`(list > 0) / list`. Because of right-to-left evaluation the mask needs parentheses. Later lessons show the tacit
forms `(0⊸<)⊸/ list` and `list /˜ list > 0`, which avoid repeating `list`.

On a table, `mask / table` filters its rows. A list of masks or counts, one per axis, `rows‿cols / table`,
filters rows and columns at once.

## Indices

Monadic `/ counts` is `counts / ↕≠counts`: each index repeated by its count. For a mask it gives the positions of
the `1`s, so

- `/ list = x` finds every position of `x`,
- `⊑ / mask` is the first position where the mask is `1` (an error when there is none),
- `≠ / mask` counts the `1`s, though `+´ mask` is shorter.

With counts, `/` turns lengths into labels: `/ 3‿2` is `⟨0, 0, 0, 1, 1⟩`, the group number of each element when the
first group has three and the second two.

## Inverse

The inverse of indices, `/⁼`, goes the other way: from a sorted list of indices to how many times each one appears.
`/⁼ 0‿0‿2` is `⟨2, 0, 1⟩`. It is a short way to count occurrences, covered with undo `⁼` in a later lesson.

## Order and emptiness

Replicate never reorders: elements keep their relative order, which is what makes it a filter. When nothing is
kept the result is an empty list of the same kind, so code built on `/` handles "none found" without special cases.
