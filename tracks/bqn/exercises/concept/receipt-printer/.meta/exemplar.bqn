width ← 20

# count Quantity name → "<count> x <name>"
Quantity ⇐ {(•Fmt 𝕨) ∾ " x " ∾ 𝕩}

ThreeDigits ← {(-3 ⌈ ≠𝕩) ↑ "00" ∾ 𝕩}   # at least three digits, zeros in front
Point ← {(¯2↓𝕩) ∾ "." ∾ ¯2↑𝕩}            # a point before the last two digits

# Cents cents → the price as text with two decimals: 1205 → "12.05"
Cents ⇐ {Point ThreeDigits •Fmt 𝕩}

# width PadLeft text → text right-aligned in width columns, padded with spaces
PadLeft ⇐ {(-𝕨) ↑ 𝕩}

# name Line cents → the 20-character receipt line: name on the left, price on the right
Line ⇐ {𝕨 ∾ (width - ≠𝕨) PadLeft Cents 𝕩}

# ParsePrice text → the price "12.05" in whole cents: 1205
ParsePrice ⇐ {⌊ 0.5 + 100 × •ParseFloat 𝕩}
