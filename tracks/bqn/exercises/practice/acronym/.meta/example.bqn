# Abbreviate phrase → the upper-case first letters of its words; words are separated by whitespace
# and hyphens, other punctuation is ignored
Upper ← {𝕩 - 32×('a'≤𝕩)∧𝕩≤'z'}
letters ← 'A'+↕26
ws ← @+9+↕5                      # tab, line feed, vertical tab, form feed, carriage return

Abbreviate ⇐ {
  s ← Upper 𝕩
  k ← (∊⟜(" -'"∾letters))⊸/ ' '¨⌾((s∊ws)⊸/) s
  ((1 » k∊" -") ∧ k∊letters) / k
}
