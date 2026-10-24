# Introduction

BQN has a family of primitives for asking where things are in a list. Each of them compares whole elements,
with the same notion of equality as match: two strings are equal only when they have the same characters in
the same order.

## Index of

`𝕨 ⊐ 𝕩` looks up each element of `𝕩` in the list `𝕨` and returns where it is first found. An element that is
not in `𝕨` gets the index `≠𝕨`, one past the end:

```bqn
"abc" ⊐ "cbz"                          # ⟨ 2 1 3 ⟩
"basil"‿"cumin"‿"dill" ⊐ "dill"‿"salt"  # ⟨ 2 3 ⟩
```

Because missing elements get `≠𝕨`, the result can be used with select to look up values in a list that has
one extra entry for "not found":

```bqn
prices ← 3‿5‿4‿0                       # the 0 is for a spice we don't stock
("basil"‿"cumin"‿"dill" ⊐ "dill"‿"salt") ⊏ prices   # ⟨ 4 0 ⟩
```

`⊐` searches for the _elements_ of `𝕩`. A string is a list of characters, so searching a list of strings for
the string `"cumin"` would look for the characters `'c'`, `'u'` and so on, and find none of them. To search for
one whole string, enclose it with `<`, which makes a single value out of it; the result is then a single
index, which `⊑` takes out:

```bqn
spices ← "basil"‿"cumin"‿"dill"
spices ⊐ "cumin"         # ⟨ 3 3 3 3 3 ⟩: no character is a spice
⊑ spices ⊐ <"cumin"      # 1
```

## Member of

`𝕨 ∊ 𝕩` turns the question around: for each element of `𝕨`, is it anywhere in `𝕩`? The result has one 1 or 0
per element of `𝕨`:

```bqn
"salt"‿"dill" ∊ "basil"‿"cumin"‿"dill"   # ⟨ 0 1 ⟩
"hello" ∊ "aeiou"                       # ⟨ 0 1 0 0 1 ⟩
```

A boolean list like this combines well with replicate: `(𝕨∊𝕩)/𝕨` keeps the elements of `𝕨` that are in `𝕩`,
and `(¬𝕨∊𝕩)/𝕨` those that are not.

## Progressive index of

`𝕨 ⊐ 𝕩` always finds the first match, however many times an element is looked up. `𝕨 ⊒ 𝕩` is like it, but
uses each element of `𝕨` only once: the second lookup of the same value finds the second copy, and when the
copies run out the result is `≠𝕨`:

```bqn
"aab" ⊐ "aaab"    # ⟨ 0 0 0 2 ⟩
"aab" ⊒ "aaab"    # ⟨ 0 1 3 2 ⟩
```

## Searching a list against itself

With only one argument, these primitives look at a list against itself:

- `⍷ 𝕩` (deduplicate) keeps the first copy of each element, in order: `⍷ "mississippi"` is `"misp"`.
- `∊ 𝕩` (mark firsts) is 1 for each element that has not appeared before it: `∊ "abca"` is `⟨ 1 1 1 0 ⟩`.
  So `(∊𝕩)/𝕩` is the same as `⍷𝕩`, and `(¬∊𝕩)/𝕩` keeps only the repeats.
- `⊐ 𝕩` (classify) numbers the distinct values in the order they first appear: `⊐ "abca"` is
  `⟨ 0 1 2 0 ⟩`. Elements that are equal get the same number.

```bqn
⍷ "salt"‿"dill"‿"salt"    # ⟨ "salt" "dill" ⟩
∊ "salt"‿"dill"‿"salt"    # ⟨ 1 1 0 ⟩
⊐ "salt"‿"dill"‿"salt"    # ⟨ 0 1 0 ⟩
```

## Pitfalls

- Mind which argument is which. `𝕨 ⊐ 𝕩` gives one result per element of `𝕩`; `𝕨 ∊ 𝕩` gives one per element of
  `𝕨`. In both, the list being searched is the other one.
- A missing element is not an error: `⊐` quietly returns `≠𝕨`. Compare with `≠𝕨` when you need to know.
- Searching for a single string needs `<`; searching for a list of strings does not.
