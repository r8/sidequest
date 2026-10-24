# zones Fare adults‿children → the group's fare: 2 + 1.5 per zone for an adult, half that for a child
Fare ⇐ {zones 𝕊 adults‿children:
  adult ← 2 + 1.5 × zones
  (adults × adult) + children × adult ÷ 2
}

# paid MakeChange price → twos‿ones: the change in 2-coin and 1-coin pieces, as many twos as possible
MakeChange ⇐ {paid 𝕊 price:
  change ← paid - price
  (⌊ change ÷ 2)‿(2 | change)
}

# start‿length Valid minute → 1 if the ticket is valid at minute (from start, before start+length), else 0
Valid ⇐ {start‿length 𝕊 minute: (minute ≥ start) ∧ minute < start + length}

# first‿every Departures n → the minutes of the first n departures
Departures ⇐ {first‿every 𝕊 n: first + every × ↕ n}

# Discounted fare‿senior‿member → the fare halved for seniors, then 1 off for members, at least 0.5
Discounted ⇐ {𝕊 fare‿senior‿member:
  fare ÷↩ 1 + senior
  fare -↩ member
  0.5 ⌈ fare
}
