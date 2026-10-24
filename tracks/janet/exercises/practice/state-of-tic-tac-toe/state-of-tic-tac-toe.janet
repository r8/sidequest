# A board is a tuple of three row strings of "X", "O" and " "; X moves first.

(defn game-state
  "(game-state board) -> :win, :draw or :ongoing; errors when the board could not occur in a game"
  [board]
  (error "implement me"))
