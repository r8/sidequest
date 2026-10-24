# Recite pieces → one line per consecutive pair of pieces, then the closing line about the first
Recite ⇐ {
  0=≠𝕩 ? ⟨⟩ ;
  lines ← (¯1↓𝕩) {"For want of a "∾𝕨∾" the "∾𝕩∾" was lost."}¨ 1↓𝕩
  lines ∾ ⟨"And all for the want of a "∾(⊑𝕩)∾"."⟩
}
