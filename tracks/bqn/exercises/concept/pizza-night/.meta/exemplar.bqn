riseTime ← 90
preheat ← 15
perPizza ← 12
ball ← 250
slices ← 8

# RiseTimeLeft minutes → the minutes of the 90-minute rise still to go
RiseTimeLeft ⇐ {riseTime - 𝕩}

# BakingTime pizzas → the minutes to heat the oven (15) and bake every pizza (12 each)
BakingTime ⇐ {preheat + perPizza × 𝕩}

# DoughNeeded pizzas → the grams of dough: 250 per pizza, plus one spare ball
DoughNeeded ⇐ {ball × 1 + 𝕩}

# pizzas TotalTime minutes → the minutes until the last pizza is baked, after the dough has risen
TotalTime ⇐ {(RiseTimeLeft 𝕩) + BakingTime 𝕨}

# guests SlicesEach pizzas → the slices each guest gets, with 8 slices per pizza
SlicesEach ⇐ {(slices × 𝕩) ÷ 𝕨}
