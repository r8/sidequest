import test
import cinema-seats

pub fun main()
  run([
    test("1. an empty row of three seats") { assert-equal([False, False, False], empty-row(3).list) },
    test("1. an empty row of one seat") { assert-equal([False], empty-row(1).list) },
    test("1. a row of no seats") { assert-equal(0, empty-row(0).length) },
    test("2. prices from a base of 10") { assert-equal([10, 11, 12, 13], seat-prices(4, 10).list) },
    test("2. prices from a base of 7") { assert-equal([7, 8], seat-prices(2, 7).list) },
    test("2. no seats, no prices") { assert-equal(0, seat-prices(0, 5).length) },
    test("3. a seat in an empty row is free") { assert-true(empty-row(3).is-free(1)) },
    test("3. a booked seat is not free") { assert-false([False, True].vector.is-free(1)) },
    test("3. a seat past the end is not free") { assert-false(empty-row(3).is-free(3)) },
    test("3. a negative seat is not free") { assert-false(empty-row(3).is-free(-1)) },
    test("4. booking a seat") { assert-equal([False, True, False], empty-row(3).book(1).list) },
    test("4. booking two seats") { assert-equal([True, False, True], empty-row(3).book(0).book(2).list) },
    test("4. booking leaves the original row free") {
      val row = empty-row(2)
      val booked = row.book(0)
      assert-equal([True, False], booked.list)
      assert-equal([False, False], row.list)
    },
    test("4. booking past the end") { assert-throws("index out of bounds") { empty-row(2).book(2) } },
    test("5. every seat free") { assert-equal(4, empty-row(4).free-count) },
    test("5. some seats booked") { assert-equal(2, empty-row(4).book(1).book(3).free-count) },
    test("5. a full row") { assert-equal(0, [True, True].vector.free-count) },
  ])
