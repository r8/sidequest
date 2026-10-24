# Positions are row‿column, each counting from 0 on an 8×8 board.

# Create position → the position, once checked; errors with "row not positive", "row not on board",
# "column not positive" or "column not on board" when it is off the board
Create ⇐ {𝕊 𝕩: "implement me" ! 0}

# white CanAttack black → 1 if the queens share a row, column or diagonal, else 0
CanAttack ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}
