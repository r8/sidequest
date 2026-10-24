# A board is a tuple of row strings, each row shifted one space further right than the one above:
# a hex board. "X" plays to connect left and right, "O" to connect top and bottom, "." is empty.

# On the de-indented grid, a hex touches these six offsets. The set is symmetric in
# row and column, so transposing the grid turns top-to-bottom into left-to-right.
(def- neighbours [[0 -1] [0 1] [-1 0] [-1 1] [1 -1] [1 0]])

(defn- crosses?
  "Does stone link the first column of cells to the last?"
  [cells stone]
  (def last-column (dec (length (cells 0))))
  (def seen @{})
  (defn reach? [r c]
    (when (and (= stone (get-in cells [r c])) (not (seen [r c])))
      (put seen [r c] true)
      (or (= c last-column)
          (some (fn [[dr dc]] (reach? (+ r dr) (+ c dc))) neighbours))))
  (some |(reach? $ 0) (range (length cells))))

(defn winner
  "(winner board) -> :X or :O for the player who has connected their sides, or nil"
  [board]
  (def cells (map |(string/replace-all " " "" $) board))
  (cond
    (crosses? cells (chr "X")) :X
    (crosses? (map tuple ;cells) (chr "O")) :O))
