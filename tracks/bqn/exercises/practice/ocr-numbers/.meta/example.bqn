# Convert rows → the digits drawn in rows (4 rows of 3 columns per digit), "?" for a garbled digit
# and "," between lines of digits; errors unless the rows and columns come in fours and threes
Convert ⇐ {
  0≠4|≠𝕩 ? "Number of input lines is not a multiple of four" ! 0 ;
  0≠3|≠⊑𝕩 ? "Number of input columns is not a multiple of three" ! 0 ;
  1↓∾ ','⊸∾¨ <˘ "0123456789?" ⊏˜ font ⊐ Cells >𝕩
}

# Cells grid → a lines×digits array of the grid's 4×3 cells, each flattened to 12 characters
Cells ← {
  l‿d ← 4‿3 ÷˜ ≢𝕩
  l‿d‿12 ⥊ 0‿2‿1‿3 ⍉ l‿4‿d‿3 ⥊ 𝕩
}

font ← ⊏ Cells > ⟨
  " _     _  _     _  _  _  _  _ "
  "| |  | _| _||_||_ |_   ||_||_|"
  "|_|  ||_  _|  | _||_|  ||_| _|"
  "                              "
⟩
