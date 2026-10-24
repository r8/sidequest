# About

## Depth

The depth of an atom is 0; the depth of an array is one more than the largest depth of its elements. So depth
measures the _deepest_ path: `≡ ⟨1, ⟨2, ⟨3⟩⟩⟩` is 3 even though `1` is shallow. An empty array has depth 1. A
list whose elements are all atoms (depth 1) is "flat"; most primitives are fastest on flat arrays.

The depth modifier `⚇` applies a function at a given depth, like rank does for axes: `F⚇0` applies `F` to
every atom however deeply nested, which is how arithmetic already behaves.

## Units and enclose

`<𝕩` makes a rank-0 array, a _unit_, holding `𝕩`. Units are how BQN treats a whole array as one value:

- `list ∾ <x` appends `x` as one element.
- `list F¨ <x` pairs `x` with every element (a unit is extended to match any shape).
- `list ⊐ <x` searches for `x` itself, not for its elements.

`⊑ <𝕩` is `𝕩`. An atom and the unit containing it are different values: `(<5) ≡ 5` is `0`, although arithmetic
treats them alike.

## Pair, couple and merge

`𝕨 ⋈ 𝕩` is `⟨𝕨, 𝕩⟩` and `⋈ 𝕩` is `⟨𝕩⟩`, for any values. `𝕨 ≍ 𝕩` (couple) instead combines two arrays of the same
shape into one array with a new leading axis of length 2: two lists become a two-row table. `> 𝕩` (merge)
does the same for a whole array of arrays: all elements must have the same shape, and the result's shape is
the outer shape followed by the inner one. `<˘` (enclose each row) undoes it, giving a list of the rows.

## Join

`∾ 𝕩` joins the elements of `𝕩` along their first axis, so a list of lists becomes one list and a list of
tables with the same number of columns becomes one taller table. It removes exactly one level of nesting;
flattening completely needs recursion, such as `{0=≡𝕩 ? ⟨𝕩⟩ ; ∾𝕊¨𝕩}`.

## Match versus equals

`≡` and `≢` compare whole values: shape, then every element, recursively. `=` and `≠` are pervasive arithmetic
comparisons on atoms; on arrays of different lengths they are a length error, where `≡` would just give 0.
Match ignores the fill element, so `""` matches `⟨⟩`.

## Display

Nested lists print with angle brackets, `⟨ "kitchen" ⟨ 1 2 3 ⟩ ⟩`. A unit prints in a box with `·` corners.
