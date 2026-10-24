import test
import saddle-points

pub fun main()
  run([
    test("Can identify single saddle point") {
      assert-equal([(2, 1)], saddle-points([[9, 8, 7], [5, 3, 2], [6, 6, 7]]))
    },
    test("Can identify that empty matrix has no saddle points") { assert-equal([], saddle-points([[]])) },
    test("Can identify lack of saddle points when there are none") {
      assert-equal([], saddle-points([[1, 2, 3], [3, 1, 2], [2, 3, 1]]))
    },
    test("Can identify multiple saddle points in a column") {
      assert-equal([(1, 2), (2, 2), (3, 2)], saddle-points([[4, 5, 4], [3, 5, 5], [1, 5, 4]]))
    },
    test("Can identify multiple saddle points in a row") {
      assert-equal([(2, 1), (2, 2), (2, 3)], saddle-points([[6, 7, 8], [5, 5, 5], [7, 5, 6]]))
    },
    test("Can identify saddle point in bottom right corner") {
      assert-equal([(3, 3)], saddle-points([[8, 7, 9], [6, 7, 6], [3, 2, 5]]))
    },
    test("Can identify saddle points in a non square matrix") {
      assert-equal([(1, 1), (1, 3)], saddle-points([[3, 1, 3], [3, 2, 4]]))
    },
    test("Can identify that saddle points in a single column matrix are those with the minimum value") {
      assert-equal([(2, 1), (4, 1)], saddle-points([[2], [1], [4], [1]]))
    },
    test("Can identify that saddle points in a single row matrix are those with the maximum value") {
      assert-equal([(1, 2), (1, 4)], saddle-points([[2, 5, 3, 5]]))
    },
  ])
