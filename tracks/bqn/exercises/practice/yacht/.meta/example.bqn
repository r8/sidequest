# dice Score category → the score of the five dice in the category: "ones" … "sixes", "full house",
# "four of a kind", "little straight", "big straight", "choice" or "yacht"
faces ← 1+↕6
categories ← ⟨
  "ones", "twos", "threes", "fours", "fives", "sixes"
  "full house", "four of a kind", "little straight", "big straight", "choice", "yacht"
⟩
Score ⇐ {
  c ← +˝ 𝕨 =⌜ faces                      # how many of each face
  (⊑categories ⊐ <𝕩) ⊑ (faces × c) ∾ ⟨
    (+´𝕨) × 2‿3 ≡ ∧ (0<c)/c
    4 × +´ faces × 4≤c
    30 × (1+↕5) ≡ ∧𝕨
    30 × (2+↕5) ≡ ∧𝕨
    +´𝕨
    50 × ∨´ 5=c
  ⟩
}
