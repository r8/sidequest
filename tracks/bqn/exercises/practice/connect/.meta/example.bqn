# Once the spaces are gone, the board is a table where row r is shifted right by r, so the six
# neighbours of a cell are left/right, up/down, up-right and down-left. That neighbourhood is the
# same in the transposed table, so O's top-to-bottom is X's left-to-right on ⍉board.
Near ← {𝕩 ∨ (»˘𝕩) ∨ («˘𝕩) ∨ (»𝕩) ∨ («𝕩) ∨ («˘»𝕩) ∨ »˘«𝕩}

# stones Spread reached → grow reached through stones until it stops changing
Spread ← {
  n ← 𝕨 ∧ Near 𝕩
  𝕨 𝕊⍟(n≢𝕩) n
}

# player Joins table → 1 if player's stones connect the first column to the last
Joins ← {
  s ← 𝕨 = 𝕩
  ∨´ ¯1 ⊏˘ s Spread s ∧⎉1 0 = ↕⊢´≢𝕩
}

Win ← {'X' Joins 𝕩 ? "X" ; 'O' Joins ⍉𝕩 ? "O" ; ""}

# Winner board → "X" if X joins the left and right edges, "O" if O joins the top and bottom edges,
# "" if nobody has; the board is a list of row strings, each row indented one more space than the last
Winner ⇐ {Win > (' '⊸≠)⊸/¨ 𝕩}
