import test
import state-of-tic-tac-toe

pub fun main()
  run([
    test("Won games > Finished game where X won via left column victory") {
      assert-equal(Win, game-state(["XOO", "X  ", "X  "]))
    },
    test("Won games > Finished game where X won via middle column victory") {
      assert-equal(Win, game-state(["OXO", " X ", " X "]))
    },
    test("Won games > Finished game where X won via right column victory") {
      assert-equal(Win, game-state(["OOX", "  X", "  X"]))
    },
    test("Won games > Finished game where O won via left column victory") {
      assert-equal(Win, game-state(["OXX", "OX ", "O  "]))
    },
    test("Won games > Finished game where O won via middle column victory") {
      assert-equal(Win, game-state(["XOX", " OX", " O "]))
    },
    test("Won games > Finished game where O won via right column victory") {
      assert-equal(Win, game-state(["XXO", " XO", "  O"]))
    },
    test("Won games > Finished game where X won via top row victory") {
      assert-equal(Win, game-state(["XXX", "XOO", "O  "]))
    },
    test("Won games > Finished game where X won via middle row victory") {
      assert-equal(Win, game-state(["O  ", "XXX", " O "]))
    },
    test("Won games > Finished game where X won via bottom row victory") {
      assert-equal(Win, game-state([" OO", "O X", "XXX"]))
    },
    test("Won games > Finished game where O won via top row victory") {
      assert-equal(Win, game-state(["OOO", "XXO", "XX "]))
    },
    test("Won games > Finished game where O won via middle row victory") {
      assert-equal(Win, game-state(["XX ", "OOO", "X  "]))
    },
    test("Won games > Finished game where O won via bottom row victory") {
      assert-equal(Win, game-state(["XOX", " XX", "OOO"]))
    },
    test("Won games > Finished game where X won via falling diagonal victory") {
      assert-equal(Win, game-state(["XOO", " X ", "  X"]))
    },
    test("Won games > Finished game where X won via rising diagonal victory") {
      assert-equal(Win, game-state(["O X", "OX ", "X  "]))
    },
    test("Won games > Finished game where O won via falling diagonal victory") {
      assert-equal(Win, game-state(["OXX", "OOX", "X O"]))
    },
    test("Won games > Finished game where O won via rising diagonal victory") {
      assert-equal(Win, game-state(["  O", " OX", "OXX"]))
    },
    test("Won games > Finished game where X won via a row and a column victory") {
      assert-equal(Win, game-state(["XXX", "XOO", "XOO"]))
    },
    test("Won games > Finished game where X won via two diagonal victories") {
      assert-equal(Win, game-state(["XOX", "OXO", "XOX"]))
    },
    test("Drawn games > Draw") {
      assert-equal(Draw, game-state(["XOX", "XXO", "OXO"]))
    },
    test("Drawn games > Another draw") {
      assert-equal(Draw, game-state(["XXO", "OXX", "XOO"]))
    },
    test("Ongoing games > Ongoing game: one move in") {
      assert-equal(Ongoing, game-state(["   ", "X  ", "   "]))
    },
    test("Ongoing games > Ongoing game: two moves in") {
      assert-equal(Ongoing, game-state(["O  ", " X ", "   "]))
    },
    test("Ongoing games > Ongoing game: five moves in") {
      assert-equal(Ongoing, game-state(["X  ", " XO", "OX "]))
    },
    test("Invalid boards > Invalid board: X went twice") {
      assert-throws("Wrong turn order: X went twice") { game-state(["XX ", "   ", "   "]) }
    },
    test("Invalid boards > Invalid board: O started") {
      assert-throws("Wrong turn order: O started") { game-state(["OOX", "   ", "   "]) }
    },
    test("Invalid boards > Invalid board: X won and O kept playing") {
      assert-throws("Impossible board: game should have ended after the game was won") { game-state(["XXX", "OOO", "   "]) }
    },
    test("Invalid boards > Invalid board: players kept playing after a win") {
      assert-throws("Impossible board: game should have ended after the game was won") { game-state(["XXX", "OOO", "XOX"]) }
    },
    test("Invalid boards > Invalid board: O kept playing after X wins") {
      assert-throws("Impossible board: game should have ended after the game was won") { game-state(["OO ", "XXX", " O "]) }
    },
    test("Invalid boards > Invalid board: X kept playing after O wins") {
      assert-throws("Impossible board: game should have ended after the game was won") { game-state(["XX ", "OOO", " XX"]) }
    },
  ])
