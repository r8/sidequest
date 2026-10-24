# Introduction

BQN arrays can hold other arrays: a list of strings is a list of lists. `≡ 𝕩` (depth) says how deep the nesting
goes: 0 for a number or character, 1 for a list of them, one more per level.

- `< 𝕩` (enclose) wraps a value so it acts as one element: `"cup"‿"mug" ∾ <"bowl"` adds one string.
- `𝕨 ⋈ 𝕩` (pair) makes the two-element list `⟨𝕨, 𝕩⟩`; `⋈ 𝕩` makes `⟨𝕩⟩`.
- `∾ 𝕩` (join) joins the elements of a list into one list: `∾ "ab"‿"cd"` is `"abcd"`.
- `> 𝕩` (merge) turns a list of equal-shaped arrays into one array of higher rank, such as a table.
- `𝕨 ≡ 𝕩` (match) compares two whole values, giving one 1 or 0; `≢` is its opposite.
