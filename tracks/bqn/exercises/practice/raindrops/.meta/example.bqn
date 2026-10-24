# Convert n → the sounds for the factors 3, 5 and 7 of n, or n itself
# Decimal n → n's digits; •Fmt writes numbers from 10⋆15 up in exponent form
Decimal ← {𝕩 < 10 ? ⋈'0'+𝕩 ; (𝕊 (𝕩-r)÷10) ∾ '0'+r ← 10|𝕩}
Convert ⇐ {
  drops ← ∾(0=3‿5‿7|𝕩)/"Pling"‿"Plang"‿"Plong"
  (0=≠drops)⊑drops‿(Decimal 𝕩)
}
