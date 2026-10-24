# Square n → the number of grains on square n of the chessboard (2 to the power n-1);
# errors with "square must be between 1 and 64" unless 1 ≤ n ≤ 64
Square ⇐ {
  (𝕩<1)∨𝕩>64 ? "square must be between 1 and 64" ! 0 ;
  2⋆𝕩-1
}
