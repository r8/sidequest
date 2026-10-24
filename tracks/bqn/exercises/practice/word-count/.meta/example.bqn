# CountWords sentence → each word‿count pair, sorted by word. Words are lowercased runs of letters,
# digits and apostrophes, without apostrophes at their ends: "Don't, don't" → ⟨"don't"‿2⟩
Lower ← +⟜(32×('A'⊸≤∧≤⟜'Z'))
Inner ← (¬∧`∨∧`⌾⌽)∘=⟜'''⊸/                   # strip apostrophes at both ends
CountWords ⇐ {
  s ← Lower 𝕩
  m ← s ∊ "abcdefghijklmnopqrstuvwxyz0123456789'"
  w ← (0<≠¨)⊸/ Inner¨ (1-˜m×+`m>»m) ⊔ s
  u ← ⍷w
  ∧ u ⋈¨ /⁼ u⊐w
}
