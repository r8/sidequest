(import test :as t)
(import ../state-of-tic-tac-toe :as sol)

(t/deftest "Finished game where X won via left column victory"
  (t/assert-equal :win (sol/game-state ["XOO" "X  " "X  "])))

(t/deftest "Finished game where X won via middle column victory"
  (t/assert-equal :win (sol/game-state ["OXO" " X " " X "])))

(t/deftest "Finished game where X won via right column victory"
  (t/assert-equal :win (sol/game-state ["OOX" "  X" "  X"])))

(t/deftest "Finished game where O won via left column victory"
  (t/assert-equal :win (sol/game-state ["OXX" "OX " "O  "])))

(t/deftest "Finished game where O won via middle column victory"
  (t/assert-equal :win (sol/game-state ["XOX" " OX" " O "])))

(t/deftest "Finished game where O won via right column victory"
  (t/assert-equal :win (sol/game-state ["XXO" " XO" "  O"])))

(t/deftest "Finished game where X won via top row victory"
  (t/assert-equal :win (sol/game-state ["XXX" "XOO" "O  "])))

(t/deftest "Finished game where X won via middle row victory"
  (t/assert-equal :win (sol/game-state ["O  " "XXX" " O "])))

(t/deftest "Finished game where X won via bottom row victory"
  (t/assert-equal :win (sol/game-state [" OO" "O X" "XXX"])))

(t/deftest "Finished game where O won via top row victory"
  (t/assert-equal :win (sol/game-state ["OOO" "XXO" "XX "])))

(t/deftest "Finished game where O won via middle row victory"
  (t/assert-equal :win (sol/game-state ["XX " "OOO" "X  "])))

(t/deftest "Finished game where O won via bottom row victory"
  (t/assert-equal :win (sol/game-state ["XOX" " XX" "OOO"])))

(t/deftest "Finished game where X won via falling diagonal victory"
  (t/assert-equal :win (sol/game-state ["XOO" " X " "  X"])))

(t/deftest "Finished game where X won via rising diagonal victory"
  (t/assert-equal :win (sol/game-state ["O X" "OX " "X  "])))

(t/deftest "Finished game where O won via falling diagonal victory"
  (t/assert-equal :win (sol/game-state ["OXX" "OOX" "X O"])))

(t/deftest "Finished game where O won via rising diagonal victory"
  (t/assert-equal :win (sol/game-state ["  O" " OX" "OXX"])))

(t/deftest "Finished game where X won via a row and a column victory"
  (t/assert-equal :win (sol/game-state ["XXX" "XOO" "XOO"])))

(t/deftest "Finished game where X won via two diagonal victories"
  (t/assert-equal :win (sol/game-state ["XOX" "OXO" "XOX"])))

(t/deftest "Draw"
  (t/assert-equal :draw (sol/game-state ["XOX" "XXO" "OXO"])))

(t/deftest "Another draw"
  (t/assert-equal :draw (sol/game-state ["XXO" "OXX" "XOO"])))

(t/deftest "Ongoing game: one move in"
  (t/assert-equal :ongoing (sol/game-state ["   " "X  " "   "])))

(t/deftest "Ongoing game: two moves in"
  (t/assert-equal :ongoing (sol/game-state ["O  " " X " "   "])))

(t/deftest "Ongoing game: five moves in"
  (t/assert-equal :ongoing (sol/game-state ["X  " " XO" "OX "])))

(t/deftest "Invalid board: X went twice"
  (t/assert-error "Wrong turn order: X went twice" (sol/game-state ["XX " "   " "   "])))

(t/deftest "Invalid board: O started"
  (t/assert-error "Wrong turn order: O started" (sol/game-state ["OOX" "   " "   "])))

(t/deftest "Invalid board: X won and O kept playing"
  (t/assert-error "Impossible board: game should have ended after the game was won" (sol/game-state ["XXX" "OOO" "   "])))

(t/deftest "Invalid board: players kept playing after a win"
  (t/assert-error "Impossible board: game should have ended after the game was won" (sol/game-state ["XXX" "OOO" "XOX"])))

(t/deftest "Invalid board: O kept playing after X wins"
  (t/assert-error "Impossible board: game should have ended after the game was won" (sol/game-state ["OO " "XXX" " O "])))

(t/deftest "Invalid board: X kept playing after O wins"
  (t/assert-error "Impossible board: game should have ended after the game was won" (sol/game-state ["XX " "OOO" " XX"])))

(t/run)
