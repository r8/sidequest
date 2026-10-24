# Ciphertext plaintext → the crypto square ciphertext: the columns of the normalized text's
# rectangle, padded with trailing spaces and separated by spaces
Lower ← {𝕩 + 32×('A'≤𝕩)∧𝕩≤'Z'}
alnum ← ('a'+↕26)∾'0'+↕10
Normalize ← (∊⟜alnum)⊸/ Lower

Ciphertext ⇐ {
  s ← Normalize 𝕩
  c ← ⌈√≠s
  r ← ⌈(≠s)÷1⌈c
  1↓∾ ' '∾¨ <˘ ⍉ r‿c ⥊ s ∾ ' ' ⥊˜ (r×c)-≠s
}
