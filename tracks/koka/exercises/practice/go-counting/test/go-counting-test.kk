import test
import go-counting

val board5x5 = [
  "  B  ",
  " B B ",
  "B W B",
  " W W ",
  "  W  ",
]

pub fun main()
  run([
    test("Black corner territory on 5x5 board") {
      assert-equal((Black, [(0, 0), (0, 1), (1, 0)]), territory(board5x5, 0, 1))
    },
    test("White center territory on 5x5 board") {
      assert-equal((White, [(2, 3)]), territory(board5x5, 2, 3))
    },
    test("Open corner territory on 5x5 board") {
      assert-equal((None, [(0, 3), (0, 4), (1, 4)]), territory(board5x5, 1, 4))
    },
    test("A stone and not a territory on 5x5 board") {
      assert-equal((None, []), territory(board5x5, 1, 1))
    },
    test("Invalid because X is too low for 5x5 board") {
      assert-throws("Invalid coordinate") { territory(board5x5, -1, 1) }
    },
    test("Invalid because X is too high for 5x5 board") {
      assert-throws("Invalid coordinate") { territory(board5x5, 5, 1) }
    },
    test("Invalid because Y is too low for 5x5 board") {
      assert-throws("Invalid coordinate") { territory(board5x5, 1, -1) }
    },
    test("Invalid because Y is too high for 5x5 board") {
      assert-throws("Invalid coordinate") { territory(board5x5, 1, 5) }
    },
    test("One territory is the whole board") {
      assert-equal(Territories([], [], [(0, 0)]), territories([" "]))
    },
    test("Two territory rectangular board") {
      assert-equal(Territories([(0, 0), (0, 1)], [(3, 0), (3, 1)], []), territories([" BW ", " BW "]))
    },
    test("Two region rectangular board") {
      assert-equal(Territories([(0, 0), (2, 0)], [], []), territories([" B "]))
    },
  ])
