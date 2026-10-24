# A board is a tuple of three row strings of "X", "O" and " "; X moves first.

(defn- won? [board player]
  (def lines [;board
              ;(map string/from-bytes ;board)
              (string/from-bytes ;(map |((board $) $) [0 1 2]))
              (string/from-bytes ;(map |((board $) (- 2 $)) [0 1 2]))])
  (has-value? lines (string/repeat player 3)))

(defn game-state
  "(game-state board) -> :win, :draw or :ongoing; errors when the board could not occur in a game"
  [board]
  (def marks (frequencies (string ;board)))
  (def xs (get marks (chr "X") 0))
  (def os (get marks (chr "O") 0))
  (def x-won (won? board "X"))
  (def o-won (won? board "O"))
  (cond
    (> os xs) (error "Wrong turn order: O started")
    (> xs (inc os)) (error "Wrong turn order: X went twice")
    (or (and x-won o-won) (and x-won (= xs os)) (and o-won (> xs os)))
    (error "Impossible board: game should have ended after the game was won")
    (or x-won o-won) :win
    (= 9 (+ xs os)) :draw
    :ongoing))
