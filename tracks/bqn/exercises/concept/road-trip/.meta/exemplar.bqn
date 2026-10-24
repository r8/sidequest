# FuelNeeded km → the litres burnt over km kilometres, at 6 litres per 100 km
FuelNeeded ⇐ {6 × 𝕩 ÷ 100}

# range Stops distance → the fuel stops on a leg of distance km, starting with a full tank that lasts range km
Stops ⇐ {0 ⌈ ¯1 + ⌈ 𝕩 ÷ 𝕨}

# start ArrivalTime hours → the hour on the 24-hour clock after driving hours from the hour start
ArrivalTime ⇐ {24 | 𝕨 + 𝕩}

# money Snacks price → the whole number of snacks money buys
Snacks ⇐ {⌊ 𝕨 ÷ 𝕩}

# east Distance north → the straight-line distance from home
Distance ⇐ {√ (𝕨 ⋆ 2) + 𝕩 ⋆ 2}
