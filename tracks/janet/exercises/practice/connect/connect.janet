# A board is a tuple of row strings, each row shifted one space further right than the one above:
# a hex board. "X" plays to connect left and right, "O" to connect top and bottom, "." is empty.

(defn winner
  "(winner board) -> :X or :O for the player who has connected their sides, or nil"
  [board]
  (error "implement me"))
