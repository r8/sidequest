# floors ByFloor letters → one pile of letters per floor up to the highest with mail; floor ¯1 is dropped
ByFloor ⇐ {𝕨 ⊔ 𝕩}

# LettersPerFloor floors → the number of letters for each floor up to the highest with mail
LettersPerFloor ⇐ {≠¨ ⊔ 𝕩}

# residents Pigeonholes recipients → one pile per resident, in order, of the letters addressed to them
Pigeonholes ⇐ {((𝕨 ⊐ 𝕩) ∾ ≠𝕨) ⊔ 𝕩}

# size Trips letters → the letters in order, in bundles of size (the last may be smaller)
Trips ⇐ {(⌊ (↕≠𝕩) ÷ 𝕨) ⊔ 𝕩}

# ByInitial names → the names in piles by first letter, piles in order of first appearance
ByInitial ⇐ {(⊐ ⊑¨ 𝕩) ⊔ 𝕩}
