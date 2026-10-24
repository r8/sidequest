# Positions are row‿column, each counting from 0 on an 8×8 board.

# Create position → the position, once checked; errors with "row not positive", "row not on board",
# "column not positive" or "column not on board" when it is off the board
Create ⇐ {
  r‿c ← 𝕩
  "row not positive" ! r ≥ 0
  "row not on board" ! r < 8
  "column not positive" ! c ≥ 0
  "column not on board" ! c < 8
  𝕩
}

# white CanAttack black → 1 if the queens share a row, column or diagonal, else 0
CanAttack ⇐ {(=´d) ∨ ∨´ 0 = d ← |𝕨-𝕩}
