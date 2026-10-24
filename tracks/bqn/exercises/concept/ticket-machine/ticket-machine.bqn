# zones Fare adults‿children → the group's fare: 2 + 1.5 per zone for an adult, half that for a child
Fare ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# paid MakeChange price → twos‿ones: the change in 2-coin and 1-coin pieces, as many twos as possible
MakeChange ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# start‿length Valid minute → 1 if the ticket is valid at minute (from start, before start+length), else 0
Valid ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# first‿every Departures n → the minutes of the first n departures
Departures ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# Discounted fare‿senior‿member → the fare halved for seniors, then 1 off for members, at least 0.5
Discounted ⇐ {𝕊 𝕩: "implement me" ! 0}
