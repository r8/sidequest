# Introduction

BQN's search functions compare whole elements:

- `𝕨 ⊐ 𝕩` (index of) gives, for each element of `𝕩`, the index of its first copy in `𝕨`, or `≠𝕨` when it is
  not there: `"abc" ⊐ "cbz"` is `⟨ 2 1 3 ⟩`.
- `𝕨 ∊ 𝕩` (member of) gives, for each element of `𝕨`, 1 if it is in `𝕩`: `"hello" ∊ "aeiou"` is
  `⟨ 0 1 0 0 1 ⟩`.
- `𝕨 ⊒ 𝕩` (progressive index of) is like `⊐` but uses each element of `𝕨` once: `"aab" ⊒ "aaab"` is
  `⟨ 0 1 3 2 ⟩`.

With one argument they search a list against itself: `⍷𝕩` keeps the first copy of each element, `∊𝕩` marks
the first copies with 1, and `⊐𝕩` numbers the distinct elements in order of appearance.

To search a list of strings for one string, enclose it: `⊑ "ab"‿"cd" ⊐ <"cd"` is `1`.
