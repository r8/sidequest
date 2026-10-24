# Lines table → the rows, columns and both diagonals
Lines ← {(<˘𝕩) ∾ (<˘⍉𝕩) ∾ ⟨0‿0⍉𝕩, 0‿0⍉⌽𝕩⟩}

# player Won table → 1 if player fills a whole line
Won ← {∨´ (∧´𝕨=⊢)¨ Lines 𝕩}

# Gamestate board → "win", "draw" or "ongoing" for a board of three row strings of 'X', 'O' and ' ';
# errors with "Wrong turn order: X went twice", "Wrong turn order: O started" or
# "Impossible board: game should have ended after the game was won" when the board can't happen
Gamestate ⇐ {
  b ← >𝕩
  x‿o ← +´˘ "XO" =⌜ ⥊b
  xw‿ow ← "XO" Won¨ <b
  "Wrong turn order: X went twice" ! x ≤ o+1
  "Wrong turn order: O started" ! o ≤ x
  "Impossible board: game should have ended after the game was won" ! ¬(xw ∧ x=o) ∨ ow ∧ x>o
  ⊑ ⟨xw∨ow, 9=x+o, 1⟩ / "win"‿"draw"‿"ongoing"
}
