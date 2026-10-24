# The board is a table (rank 2) of 1 (live) and 0 (dead) cells; the empty board is a 0×0 table.

Sum3 ← {(»𝕩)+𝕩+«𝕩}           # each cell plus its neighbours along the first axis
Box ← ⍉∘Sum3∘⍉∘Sum3          # the 3×3 sum around each cell, itself included

# Tick board → the board one generation later
Tick ⇐ {(3=s) ∨ 𝕩∧4=s ← Box 𝕩}
