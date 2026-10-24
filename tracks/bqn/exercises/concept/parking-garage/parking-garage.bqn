# Rate vehicle → the hourly rate: "motorbike" 1, "car" 2, "van" 3, anything else 4
Rate ⇐ {𝕊 𝕩: "implement me" ! 0}

# Fee hours → 2 coins an hour after a free first hour, at most 20
Fee ⇐ {𝕊 𝕩: "implement me" ! 0}

# Floor height → "ground" above 2.2 m, "middle" above 1.6 m, else "roof"
Floor ⇐ {𝕊 𝕩: "implement me" ! 0}

# Charge hours → the fee; voucher Charge hours → half the fee for "HALF", 0 for "FREE", else the fee
Charge ⇐ {𝕊 𝕩: "implement me" ! 0 ; 𝕨 𝕊 𝕩: "implement me" ! 0}

# Sign capacity‿occupied → the number of free spaces, or "FULL" when there are none
Sign ⇐ {𝕊 𝕩: "implement me" ! 0}
