import test
import queen-attack

pub fun main()
  run([
    test("Test creation of Queens with valid and invalid positions > queen with a valid position") {
      assert-equal(Queen(2, 2), create(2, 2))
    },
    test("Test creation of Queens with valid and invalid positions > queen must have positive row") {
      assert-throws("row not positive") { create(-2, 2) }
    },
    test("Test creation of Queens with valid and invalid positions > queen must have row on board") {
      assert-throws("row not on board") { create(8, 4) }
    },
    test("Test creation of Queens with valid and invalid positions > queen must have positive column") {
      assert-throws("column not positive") { create(2, -2) }
    },
    test("Test creation of Queens with valid and invalid positions > queen must have column on board") {
      assert-throws("column not on board") { create(4, 8) }
    },
    test("Test the ability of one queen to attack another > cannot attack") {
      assert-false(can-attack(Queen(2, 4), Queen(6, 6)))
    },
    test("Test the ability of one queen to attack another > can attack on same row") {
      assert-true(can-attack(Queen(2, 4), Queen(2, 6)))
    },
    test("Test the ability of one queen to attack another > can attack on same column") {
      assert-true(can-attack(Queen(4, 5), Queen(2, 5)))
    },
    test("Test the ability of one queen to attack another > can attack on first diagonal") {
      assert-true(can-attack(Queen(2, 2), Queen(0, 4)))
    },
    test("Test the ability of one queen to attack another > can attack on second diagonal") {
      assert-true(can-attack(Queen(2, 2), Queen(3, 1)))
    },
    test("Test the ability of one queen to attack another > can attack on third diagonal") {
      assert-true(can-attack(Queen(2, 2), Queen(1, 1)))
    },
    test("Test the ability of one queen to attack another > can attack on fourth diagonal") {
      assert-true(can-attack(Queen(1, 7), Queen(0, 6)))
    },
    test("Test the ability of one queen to attack another > cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal") {
      assert-false(can-attack(Queen(4, 1), Queen(2, 5)))
    },
  ])
