# Factors n → the prime factors of n in ascending order, repeated by multiplicity (⟨⟩ for 1)
# The smallest divisor up to √n is prime; if there is none, n itself is.
Factors ⇐ {
  𝕩 = 1 ? ⟨⟩ ;
  p ← ⊑ 𝕩 ∾˜ (0=c|𝕩) / c ← 2+↕0⌈¯1+⌊√𝕩
  p ∾ 𝕊 𝕩÷p
}
