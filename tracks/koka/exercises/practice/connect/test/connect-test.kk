import test
import connect

pub fun main()
  run([
    test("an empty board has no winner") {
      val board = [
        ". . . . .",
        " . . . . .",
        "  . . . . .",
        "   . . . . .",
        "    . . . . .",
      ]
      assert-equal(Nothing, winner(board))
    },
    test("X can win on a 1x1 board") {
      assert-equal(Just(X), winner(["X"]))
    },
    test("O can win on a 1x1 board") {
      assert-equal(Just(O), winner(["O"]))
    },
    test("only edges does not make a winner") {
      val board = [
        "O O O X",
        " X . . X",
        "  X . . X",
        "   X O O O",
      ]
      assert-equal(Nothing, winner(board))
    },
    test("illegal diagonal does not make a winner") {
      val board = [
        "X O . .",
        " O X X X",
        "  O X O .",
        "   . O X .",
        "    X X O O",
      ]
      assert-equal(Nothing, winner(board))
    },
    test("nobody wins crossing adjacent angles") {
      val board = [
        "X . . .",
        " . X O .",
        "  O . X O",
        "   . O . X",
        "    . . O .",
      ]
      assert-equal(Nothing, winner(board))
    },
    test("X wins crossing from left to right") {
      val board = [
        ". O . .",
        " O X X X",
        "  O X O .",
        "   X X O X",
        "    . O X .",
      ]
      assert-equal(Just(X), winner(board))
    },
    test("X wins with left-hand dead end fork") {
      val board = [
        ". . X .",
        " X X . .",
        "  . X X X",
        "   O O O O",
      ]
      assert-equal(Just(X), winner(board))
    },
    test("X wins with right-hand dead end fork") {
      val board = [
        ". . X X",
        " X X . .",
        "  . X X .",
        "   O O O O",
      ]
      assert-equal(Just(X), winner(board))
    },
    test("O wins crossing from top to bottom") {
      val board = [
        ". O . .",
        " O X X X",
        "  O O O .",
        "   X X O X",
        "    . O X .",
      ]
      assert-equal(Just(O), winner(board))
    },
    test("X wins using a convoluted path") {
      val board = [
        ". X X . .",
        " X . X . X",
        "  . X . X .",
        "   . X X . .",
        "    O O O O O",
      ]
      assert-equal(Just(X), winner(board))
    },
    test("X wins using a spiral path") {
      val board = [
        "O X X X X X X X X",
        " O X O O O O O O O",
        "  O X O X X X X X O",
        "   O X O X O O O X O",
        "    O X O X X X O X O",
        "     O X O O O X O X O",
        "      O X X X X X O X O",
        "       O O O O O O O X O",
        "        X X X X X X X X O",
      ]
      assert-equal(Just(X), winner(board))
    },
  ])
