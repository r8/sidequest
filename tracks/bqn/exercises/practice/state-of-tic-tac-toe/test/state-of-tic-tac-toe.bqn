t ← •Import "../lib/test.bqn"
g ← •Import "../state-of-tic-tac-toe.bqn"

ended ← "Impossible board: game should have ended after the game was won"

t.Run ⟨
  "Won games > Finished game where X won via left column victory"‿{𝕊: "win" t.Expect g.Gamestate "XOO"‿"X  "‿"X  "}
  "Won games > Finished game where X won via middle column victory"‿{𝕊: "win" t.Expect g.Gamestate "OXO"‿" X "‿" X "}
  "Won games > Finished game where X won via right column victory"‿{𝕊: "win" t.Expect g.Gamestate "OOX"‿"  X"‿"  X"}
  "Won games > Finished game where O won via left column victory"‿{𝕊: "win" t.Expect g.Gamestate "OXX"‿"OX "‿"O  "}
  "Won games > Finished game where O won via middle column victory"‿{𝕊: "win" t.Expect g.Gamestate "XOX"‿" OX"‿" O "}
  "Won games > Finished game where O won via right column victory"‿{𝕊: "win" t.Expect g.Gamestate "XXO"‿" XO"‿"  O"}
  "Won games > Finished game where X won via top row victory"‿{𝕊: "win" t.Expect g.Gamestate "XXX"‿"XOO"‿"O  "}
  "Won games > Finished game where X won via middle row victory"‿{𝕊: "win" t.Expect g.Gamestate "O  "‿"XXX"‿" O "}
  "Won games > Finished game where X won via bottom row victory"‿{𝕊: "win" t.Expect g.Gamestate " OO"‿"O X"‿"XXX"}
  "Won games > Finished game where O won via top row victory"‿{𝕊: "win" t.Expect g.Gamestate "OOO"‿"XXO"‿"XX "}
  "Won games > Finished game where O won via middle row victory"‿{𝕊: "win" t.Expect g.Gamestate "XX "‿"OOO"‿"X  "}
  "Won games > Finished game where O won via bottom row victory"‿{𝕊: "win" t.Expect g.Gamestate "XOX"‿" XX"‿"OOO"}
  "Won games > Finished game where X won via falling diagonal victory"‿{𝕊: "win" t.Expect g.Gamestate "XOO"‿" X "‿"  X"}
  "Won games > Finished game where X won via rising diagonal victory"‿{𝕊: "win" t.Expect g.Gamestate "O X"‿"OX "‿"X  "}
  "Won games > Finished game where O won via falling diagonal victory"‿{𝕊: "win" t.Expect g.Gamestate "OXX"‿"OOX"‿"X O"}
  "Won games > Finished game where O won via rising diagonal victory"‿{𝕊: "win" t.Expect g.Gamestate "  O"‿" OX"‿"OXX"}
  "Won games > Finished game where X won via a row and a column victory"‿{𝕊: "win" t.Expect g.Gamestate "XXX"‿"XOO"‿"XOO"}
  "Won games > Finished game where X won via two diagonal victories"‿{𝕊: "win" t.Expect g.Gamestate "XOX"‿"OXO"‿"XOX"}
  "Drawn games > Draw"‿{𝕊: "draw" t.Expect g.Gamestate "XOX"‿"XXO"‿"OXO"}
  "Drawn games > Another draw"‿{𝕊: "draw" t.Expect g.Gamestate "XXO"‿"OXX"‿"XOO"}
  "Ongoing games > Ongoing game: one move in"‿{𝕊: "ongoing" t.Expect g.Gamestate "   "‿"X  "‿"   "}
  "Ongoing games > Ongoing game: two moves in"‿{𝕊: "ongoing" t.Expect g.Gamestate "O  "‿" X "‿"   "}
  "Ongoing games > Ongoing game: five moves in"‿{𝕊: "ongoing" t.Expect g.Gamestate "X  "‿" XO"‿"OX "}
  "Invalid boards > Invalid board: X went twice"‿{𝕊: {𝕊: g.Gamestate "XX "‿"   "‿"   "} t._throws "Wrong turn order: X went twice"}
  "Invalid boards > Invalid board: O started"‿{𝕊: {𝕊: g.Gamestate "OOX"‿"   "‿"   "} t._throws "Wrong turn order: O started"}
  "Invalid boards > Invalid board: X won and O kept playing"‿{𝕊: {𝕊: g.Gamestate "XXX"‿"OOO"‿"   "} t._throws ended}
  "Invalid boards > Invalid board: players kept playing after a win"‿{𝕊: {𝕊: g.Gamestate "XXX"‿"OOO"‿"XOX"} t._throws ended}
  "Invalid boards > Invalid board: O kept playing after X wins"‿{𝕊: {𝕊: g.Gamestate "OO "‿"XXX"‿" O "} t._throws ended}
  "Invalid boards > Invalid board: X kept playing after O wins"‿{𝕊: {𝕊: g.Gamestate "XX "‿"OOO"‿" XX"} t._throws ended}
⟩
