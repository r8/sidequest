# CheckWeight kg → kg; errors with "weight must be positive" (0 or less) or "too heavy" (over 30)
CheckWeight ⇐ {𝕊 𝕩: "implement me" ! 0}

# Volume length‿width‿height → their product; errors with "sides must be positive", then "too big" (sum over 150)
Volume ⇐ {𝕊 𝕩: "implement me" ! 0}

# rate Postage kg → rate × kg, raising CheckWeight's errors for an invalid kg
Postage ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# SafeWeight kg → kg if CheckWeight accepts it, else 0
SafeWeight ⇐ {𝕊 𝕩: "implement me" ! 0}

# Inspect length‿width‿height → "ok" if Volume accepts the sides, else the message of its error
Inspect ⇐ {𝕊 𝕩: "implement me" ! 0}
