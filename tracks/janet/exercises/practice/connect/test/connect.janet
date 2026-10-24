(import test :as t)
(import ../connect :as sol)

(t/deftest "an empty board has no winner"
  (t/assert-equal
    nil
    (sol/winner [". . . . ."
                 " . . . . ."
                 "  . . . . ."
                 "   . . . . ."
                 "    . . . . ."])))

(t/deftest "X can win on a 1x1 board"
  (t/assert-equal
    :X
    (sol/winner ["X"])))

(t/deftest "O can win on a 1x1 board"
  (t/assert-equal
    :O
    (sol/winner ["O"])))

(t/deftest "only edges does not make a winner"
  (t/assert-equal
    nil
    (sol/winner ["O O O X"
                 " X . . X"
                 "  X . . X"
                 "   X O O O"])))

(t/deftest "illegal diagonal does not make a winner"
  (t/assert-equal
    nil
    (sol/winner ["X O . ."
                 " O X X X"
                 "  O X O ."
                 "   . O X ."
                 "    X X O O"])))

(t/deftest "nobody wins crossing adjacent angles"
  (t/assert-equal
    nil
    (sol/winner ["X . . ."
                 " . X O ."
                 "  O . X O"
                 "   . O . X"
                 "    . . O ."])))

(t/deftest "X wins crossing from left to right"
  (t/assert-equal
    :X
    (sol/winner [". O . ."
                 " O X X X"
                 "  O X O ."
                 "   X X O X"
                 "    . O X ."])))

(t/deftest "X wins with left-hand dead end fork"
  (t/assert-equal
    :X
    (sol/winner [". . X ."
                 " X X . ."
                 "  . X X X"
                 "   O O O O"])))

(t/deftest "X wins with right-hand dead end fork"
  (t/assert-equal
    :X
    (sol/winner [". . X X"
                 " X X . ."
                 "  . X X ."
                 "   O O O O"])))

(t/deftest "O wins crossing from top to bottom"
  (t/assert-equal
    :O
    (sol/winner [". O . ."
                 " O X X X"
                 "  O O O ."
                 "   X X O X"
                 "    . O X ."])))

(t/deftest "X wins using a convoluted path"
  (t/assert-equal
    :X
    (sol/winner [". X X . ."
                 " X . X . X"
                 "  . X . X ."
                 "   . X X . ."
                 "    O O O O O"])))

(t/deftest "X wins using a spiral path"
  (t/assert-equal
    :X
    (sol/winner ["O X X X X X X X X"
                 " O X O O O O O O O"
                 "  O X O X X X X X O"
                 "   O X O X O O O X O"
                 "    O X O X X X O X O"
                 "     O X O O O X O X O"
                 "      O X X X X X O X O"
                 "       O O O O O O O X O"
                 "        X X X X X X X X O"])))

(t/run)
