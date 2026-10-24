t ← •Import "../lib/test.bqn"
g ← •Import "../connect.bqn"

spiral ← ⟨
  "O X X X X X X X X"
  " O X O O O O O O O"
  "  O X O X X X X X O"
  "   O X O X O O O X O"
  "    O X O X X X O X O"
  "     O X O O O X O X O"
  "      O X X X X X O X O"
  "       O O O O O O O X O"
  "        X X X X X X X X O"
⟩

t.Run ⟨
  "an empty board has no winner"‿{𝕊: "" t.Expect g.Winner ". . . . ."‿" . . . . ."‿"  . . . . ."‿"   . . . . ."‿"    . . . . ."}
  "X can win on a 1x1 board"‿{𝕊: "X" t.Expect g.Winner ⟨"X"⟩}
  "O can win on a 1x1 board"‿{𝕊: "O" t.Expect g.Winner ⟨"O"⟩}
  "only edges does not make a winner"‿{𝕊: "" t.Expect g.Winner "O O O X"‿" X . . X"‿"  X . . X"‿"   X O O O"}
  "illegal diagonal does not make a winner"‿{𝕊: "" t.Expect g.Winner "X O . ."‿" O X X X"‿"  O X O ."‿"   . O X ."‿"    X X O O"}
  "nobody wins crossing adjacent angles"‿{𝕊: "" t.Expect g.Winner "X . . ."‿" . X O ."‿"  O . X O"‿"   . O . X"‿"    . . O ."}
  "X wins crossing from left to right"‿{𝕊: "X" t.Expect g.Winner ". O . ."‿" O X X X"‿"  O X O ."‿"   X X O X"‿"    . O X ."}
  "X wins with left-hand dead end fork"‿{𝕊: "X" t.Expect g.Winner ". . X ."‿" X X . ."‿"  . X X X"‿"   O O O O"}
  "X wins with right-hand dead end fork"‿{𝕊: "X" t.Expect g.Winner ". . X X"‿" X X . ."‿"  . X X ."‿"   O O O O"}
  "O wins crossing from top to bottom"‿{𝕊: "O" t.Expect g.Winner ". O . ."‿" O X X X"‿"  O O O ."‿"   X X O X"‿"    . O X ."}
  "X wins using a convoluted path"‿{𝕊: "X" t.Expect g.Winner ". X X . ."‿" X . X . X"‿"  . X . X ."‿"   . X X . ."‿"    O O O O O"}
  "X wins using a spiral path"‿{𝕊: "X" t.Expect g.Winner spiral}
⟩
