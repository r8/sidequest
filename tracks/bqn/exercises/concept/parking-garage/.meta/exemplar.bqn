# Rate vehicle → the hourly rate: "motorbike" 1, "car" 2, "van" 3, anything else 4
Rate ⇐ {𝕊 "motorbike": 1 ; 𝕊 "car": 2 ; 𝕊 "van": 3 ; 𝕊 𝕩: 4}

# Fee hours → 2 coins an hour after a free first hour, at most 20
Fee ⇐ {𝕩 ≤ 1 ? 0 ; 20 ⌊ 2 × 𝕩 - 1}

# Floor height → "ground" above 2.2 m, "middle" above 1.6 m, else "roof"
Floor ⇐ {𝕩 > 2.2 ? "ground" ; 𝕩 > 1.6 ? "middle" ; "roof"}

# Charge hours → the fee; voucher Charge hours → half the fee for "HALF", 0 for "FREE", else the fee
Charge ⇐ {
  𝕊 hours: Fee hours ;
  "HALF" 𝕊 hours: (Fee hours) ÷ 2 ;
  "FREE" 𝕊 hours: 0 ;
  𝕨 𝕊 hours: Fee hours
}

# Sign capacity‿occupied → the number of free spaces, or "FULL" when there are none
Sign ⇐ {𝕊 capacity‿occupied: capacity ≤ occupied ? "FULL" ; 𝕊 capacity‿occupied: capacity - occupied}
