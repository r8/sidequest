# Lines table → the position lists of every row, column and diagonal, in both directions
Lines ← {
  i ← ↕≢𝕩
  l ← (<˘i) ∾ (<˘⍉i) ∾ ((⊐-´¨⥊i) ⊔ ⥊i) ∾ (⊐+´¨⥊i) ⊔ ⥊i
  l ∾ ⌽¨l
}

# grid Search words → for each word, in order, ⟨start, end⟩ where start and end are the row‿column
# positions (counting from 1) of its first and last letters, or ⟨⟩ if the word is not in the grid;
# the grid is a list of row strings, and words read in any of the eight straight directions
Search ⇐ {
  g ← >𝕨
  lines ← Lines g
  texts ← lines ⊑¨ <g
  Find ← {
    ends ← 0 ∾ ¯1+≠𝕩                          # offsets of the first and last letters
    hits ← ∾ lines {<˘ 1 + ((/𝕩) +⌜ ends) ⊏ 𝕨}¨ 𝕩⊸⍷¨ texts
    ⊑ hits ∾ <⟨⟩
  }
  Find¨ 𝕩
}
