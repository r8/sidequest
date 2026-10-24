clearance ← 6

# CanPass mast → 1 if a mast of that many metres fits under the closed bridge (lower than 6), else 0
CanPass ⇐ {𝕩 < clearance}

# IsRushHour hour → 1 from 7 to 9 and from 16 to 18, both ends included, else 0
IsRushHour ⇐ {((7 ≤ 𝕩) ∧ 𝕩 ≤ 9) ∨ (16 ≤ 𝕩) ∧ 𝕩 ≤ 18}

# hour MustRaise mast → 1 if the boat does not fit and it is not rush hour, else 0
MustRaise ⇐ {(¬ IsRushHour 𝕨) ∧ ¬ CanPass 𝕩}

# resident Toll trailer → the toll in coins: 2, plus 3 with a trailer, nothing for residents
Toll ⇐ {(¬ 𝕨) × 2 + 3 × 𝕩}

# lamp BulbBlown lamp → 1 if exactly one of the two lamps is lit, else 0
BulbBlown ⇐ {𝕨 ≠ 𝕩}
