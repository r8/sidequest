import test
import game-of-life

pub fun main()
  run([
    test("empty matrix") { assert-equal([], tick([])) },
    test("live cells with zero live neighbors die") {
      assert-equal([[0, 0, 0], [0, 0, 0], [0, 0, 0]], tick([[0, 0, 0], [0, 1, 0], [0, 0, 0]]))
    },
    test("live cells with only one live neighbor die") {
      assert-equal([[0, 0, 0], [0, 0, 0], [0, 0, 0]], tick([[0, 0, 0], [0, 1, 0], [0, 1, 0]]))
    },
    test("live cells with two live neighbors stay alive") {
      assert-equal([[0, 0, 0], [1, 0, 1], [0, 0, 0]], tick([[1, 0, 1], [1, 0, 1], [1, 0, 1]]))
    },
    test("live cells with three live neighbors stay alive") {
      assert-equal([[0, 0, 0], [1, 0, 0], [1, 1, 0]], tick([[0, 1, 0], [1, 0, 0], [1, 1, 0]]))
    },
    test("dead cells with three live neighbors become alive") {
      assert-equal([[0, 0, 0], [1, 1, 0], [0, 0, 0]], tick([[1, 1, 0], [0, 0, 0], [1, 0, 0]]))
    },
    test("live cells with four or more neighbors die") {
      assert-equal([[1, 0, 1], [0, 0, 0], [1, 0, 1]], tick([[1, 1, 1], [1, 1, 1], [1, 1, 1]]))
    },
    test("bigger matrix") {
      val matrix = [
        [1, 1, 0, 1, 1, 0, 0, 0],
        [1, 0, 1, 1, 0, 0, 0, 0],
        [1, 1, 1, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 0],
        [1, 0, 0, 0, 1, 1, 0, 0],
        [1, 1, 0, 0, 0, 1, 1, 1],
        [0, 0, 1, 0, 1, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 1, 1],
      ]
      val expected = [
        [1, 1, 0, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 1, 0],
        [1, 0, 1, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 0, 0, 1, 0, 0, 1],
        [1, 1, 0, 1, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 1],
      ]
      assert-equal(expected, tick(matrix))
    },
  ])
