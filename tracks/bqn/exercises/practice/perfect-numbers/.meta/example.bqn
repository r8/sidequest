# Classify n → "perfect", "abundant" or "deficient", comparing n with the sum of its proper divisors;
# errors with "Classification is only possible for positive integers." unless n ≥ 1
Classify ⇐ {
  𝕩 < 1 ? "Classification is only possible for positive integers." ! 0 ;
  d ← (0=c|𝕩) / c ← 1+↕⌊√𝕩     # divisors up to √n
  aliquot ← 𝕩 -˜ +´ ⍷ d ∾ 𝕩÷d  # with their partners, each once, less n itself
  (1+×aliquot-𝕩) ⊑ "deficient"‿"perfect"‿"abundant"
}
