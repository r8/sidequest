# Introduction

`𝕨 ⊔ 𝕩` (group) sorts the elements of `𝕩` into groups. `𝕨` has one group index per element: element `i` of
`𝕩` goes into group `i⊑𝕨`. The result is a list of groups, as many as the largest index plus one, with each
group's elements in their original order:

```bqn
2‿0‿2‿1 ⊔ "abcd"       # ⟨ "b" "d" "ac" ⟩
```

An index of `¯1` drops the element. One extra number at the end of `𝕨` sets the least number of groups, so
empty groups at the end are not lost: `0‿0‿4 ⊔ "ab"` has four groups.

Group indices are usually computed: `(⊐𝕩) ⊔ 𝕩` puts equal values together, `(keys ⊐ 𝕩) ⊔ 𝕩` groups in the
order of a list of keys, and `(⌊(↕≠𝕩)÷n) ⊔ 𝕩` cuts a list into chunks of `n`.

`⊔ 𝕩` groups the indices `↕≠𝕩` instead: group `i` holds the positions where `𝕩` is `i`, and `≠¨⊔𝕩` counts them.
