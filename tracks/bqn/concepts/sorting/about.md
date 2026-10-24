# About

## Sort and grade

`∧ 𝕩` and `∨ 𝕩` sort the major cells of `𝕩` (the elements of a list, the rows of a table) up or down. `⍋ 𝕩` and
`⍒ 𝕩` return the permutation that does so, which means `∧ 𝕩` is `(⍋𝕩) ⊏ 𝕩`. Grades are stable: elements that
are equal stay in their original order, for `⍒` as for `⍋`. That makes `∨ 𝕩` different from `⌽ ∧ 𝕩` only in
the order of equal elements, which for plain numbers can't be seen, but matters when sorting by a key.

## The array ordering

All BQN values can be compared. Numbers come first, in numeric order, then characters by code point. Arrays
are compared element by element in index order; when one runs out first, the shorter array is smaller. An
atom compared with an array is compared with the array's first element, and is smaller when they tie:

```bqn
∧ ⟨'a', 3, "ab", 1⟩    # ⟨ 1 3 'a' "ab" ⟩
```

Tables sort by rows, comparing rows like words. Functions and namespaces cannot be sorted.

## Sorting by a key

Sorting one list by another is `(⍋ keys) ⊏ values`. To sort by a computed key, grade the key: the names
ordered by length are `(⍋ ≠¨ names) ⊏ names`. For several keys, grade a list of pairs, since lists compare
element by element: `⍋ primary ⋈¨ secondary`.

## Ranking

`⍋ ⍋ 𝕩` is the inverse permutation of the grade, which is each element's 0-based position in the sorted order,
with ties broken by position. Ranks where equal values share a place are a different computation, such as
`(∧𝕩) ⊐ 𝕩`, the index of the first sorted copy of each value.

## Bins

With a left argument, `𝕨 ⍋ 𝕩` and `𝕨 ⍒ 𝕩` are not grades but _bins_: `𝕨` must already be sorted, and for each
element of `𝕩` the result counts how many elements of `𝕨` are less than or equal to it. That is a binary search,
useful for looking up which bracket a value falls in:

```bqn
10‿20‿30 ⍋ 5‿10‿25‿35    # ⟨ 0 1 2 3 ⟩
```
