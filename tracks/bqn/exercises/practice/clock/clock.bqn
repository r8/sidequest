# Clocks are values, not objects: the same time of day must always give the same (≡) clock,
# so choose a normalised representation.

# Create hour‿minute → a clock; hours and minutes may be out of range or negative, and roll over
Create ⇐ {𝕊 𝕩: "implement me" ! 0}

# ToString clock → the time as "HH:MM"
ToString ⇐ {𝕊 𝕩: "implement me" ! 0}

# clock Add minutes → the clock that many minutes later
Add ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# clock Subtract minutes → the clock that many minutes earlier
Subtract ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}
