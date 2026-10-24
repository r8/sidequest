# IsArmstrongNumber n → 1 if n is the sum of its digits each raised to the number of digits, else 0
# The digits come from arithmetic: •Fmt writes numbers from 10⋆15 up in exponent form.
Digits ← {𝕩 < 10 ? ⋈𝕩 ; (𝕊 (𝕩-r)÷10) ∾ r ← 10|𝕩}
IsArmstrongNumber ⇐ {𝕩 = +´ ⋆⟜≠ Digits 𝕩}
