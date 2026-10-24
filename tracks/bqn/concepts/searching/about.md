# About

## Index of and member of

`𝕨 ⊐ 𝕩` returns, for each element of `𝕩`, the index of the first matching element of `𝕨`, or `≠𝕨` if there is
none. `𝕨 ∊ 𝕩` returns, for each element of `𝕨`, whether it matches some element of `𝕩`. Matching is the same
as `≡`: values must agree in shape and in every element, so `"cumin"` matches only `"cumin"`, and `3` matches
`3.0` because they are the same number.

The result of `⊐` has the shape of `𝕩` (when `𝕨` is a list), so searching for an enclosed value `<v` gives a
unit, and `⊑` takes the index out of it. Searching for a string without `<` searches for its characters.

The out-of-range index `≠𝕨` is useful: appending a default to the list being indexed, as in
`(keys ⊐ wanted) ⊏ values ∾ default`, turns a search into a lookup table with a fallback.

## Progressive index of

`𝕨 ⊒ 𝕩` matches each element of `𝕨` at most once, scanning `𝕩` from left to right. It is the tool for
pairing up equal items from two collections, such as stock and orders. Elements of `𝕩` left without a partner
get `≠𝕨`.

## Self-search

| function | result for `"abacb"` | meaning |
| --- | --- | --- |
| `⍷𝕩` deduplicate | `"abc"` | first copy of each value |
| `∊𝕩` mark firsts | `⟨ 1 1 0 1 0 ⟩` | is this the first copy? |
| `⊐𝕩` classify | `⟨ 0 1 0 2 1 ⟩` | index of the value in `⍷𝕩` |
| `⊒𝕩` occurrence count | `⟨ 0 0 1 0 1 ⟩` | how many copies came before |

These answer common questions with no loop: `∧´∊𝕩` says whether every element is unique, `(¬∊𝕩)/𝕩` lists
the repeats, and `⊐𝕩` turns arbitrary values into small numbers suitable for grouping with `⊔`.

## Higher ranks

`𝕨` may be any array of rank at least 1; the search is then over its major cells (the rows of a table), and
`𝕩` is split into cells of the same rank. `⍷`, `∊` and `⊐` likewise work on the rows of a table. Searching
a table of characters for rows finds whole rows, which is another way to search for strings of equal length.

## Find

The related `𝕨 ⍷ 𝕩` (find) is not a search for elements: it marks every position where the whole list `𝕨`
appears as a contiguous part of `𝕩`. `"ab" ⍷ "cabab"` is `⟨ 0 1 0 1 ⟩`.
