# count Quantity name → "<count> x <name>"
Quantity ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# Cents cents → the price as text with two decimals: 1205 → "12.05"
Cents ⇐ {𝕊 𝕩: "implement me" ! 0}

# width PadLeft text → text right-aligned in width columns, padded with spaces
PadLeft ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# name Line cents → the 20-character receipt line: name on the left, price on the right
Line ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# ParsePrice text → the price "12.05" in whole cents: 1205
ParsePrice ⇐ {𝕊 𝕩: "implement me" ! 0}
