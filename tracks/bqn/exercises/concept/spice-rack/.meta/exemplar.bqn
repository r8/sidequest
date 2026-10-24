# rack Slots spices → the slot of the first jar of each spice, ≠rack for one not on the rack
Slots ⇐ {𝕨 ⊐ 𝕩}

# rack Missing recipe → the spices of the recipe that are not on the rack, in order
Missing ⇐ {(¬𝕩 ∊ 𝕨) / 𝕩}

# rack JarsFor steps → the slot of the jar each step empties, each jar used once, ≠rack when none is left
JarsFor ⇐ {𝕨 ⊒ 𝕩}

# Restock spices → each spice once, in the order it first appears
Restock ⇐ {⍷ 𝕩}

# Spares rack → the jars whose spice already has a jar further left, in order
Spares ⇐ {(¬∊ 𝕩) / 𝕩}
