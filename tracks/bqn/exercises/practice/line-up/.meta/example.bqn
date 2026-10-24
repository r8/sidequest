# name Format number → the greeting telling name their ordinal place in the line
Format ⇐ {
  i ← (1≠10|⌊𝕩÷10) × 10|𝕩
  ord ← (•Fmt 𝕩) ∾ (i×i<4) ⊑ "th"‿"st"‿"nd"‿"rd"
  𝕨 ∾ ", you are the " ∾ ord ∾ " customer we serve today. Thank you!"
}
