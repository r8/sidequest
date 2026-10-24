# CanPass mast → 1 if a mast of that many metres fits under the closed bridge (lower than 6), else 0
CanPass ⇐ {𝕊 𝕩: "implement me" ! 0}

# IsRushHour hour → 1 from 7 to 9 and from 16 to 18, both ends included, else 0
IsRushHour ⇐ {𝕊 𝕩: "implement me" ! 0}

# hour MustRaise mast → 1 if the boat does not fit and it is not rush hour, else 0
MustRaise ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# resident Toll trailer → the toll in coins: 2, plus 3 with a trailer, nothing for residents
Toll ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# lamp BulbBlown lamp → 1 if exactly one of the two lamps is lit, else 0
BulbBlown ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}
