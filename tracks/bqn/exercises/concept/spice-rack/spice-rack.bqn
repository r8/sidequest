# rack Slots spices → the slot of the first jar of each spice, ≠rack for one not on the rack
Slots ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# rack Missing recipe → the spices of the recipe that are not on the rack, in order
Missing ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# rack JarsFor steps → the slot of the jar each step empties, each jar used once, ≠rack when none is left
JarsFor ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# Restock spices → each spice once, in the order it first appears
Restock ⇐ {𝕊 𝕩: "implement me" ! 0}

# Spares rack → the jars whose spice already has a jar further left, in order
Spares ⇐ {𝕊 𝕩: "implement me" ! 0}
