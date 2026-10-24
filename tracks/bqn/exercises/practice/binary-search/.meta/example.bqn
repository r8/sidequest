# sortedArray Find value → the index of value in sortedArray, counting from 0; errors with
# "value not in array" if it isn't there
# Dyadic ⍋ is a binary search: 𝕨⍋𝕩 counts the elements of 𝕨 that are at most 𝕩, so the last of them
# is the only candidate. When there is none, i is ¯1 and picks the @ appended, which matches no number.
Find ⇐ {
  i ← ¯1 + ⊑𝕨 ⍋ 𝕩
  "value not in array" ! 𝕩 ≡ i ⊑ 𝕨∾@
  i
}
