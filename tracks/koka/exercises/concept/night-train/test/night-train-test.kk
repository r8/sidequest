import test
import night-train

pub fun main()
  run([
    test("1. late evening is night") { assert-true(is-night(23)) },
    test("1. ten o'clock is night") { assert-true(is-night(22)) },
    test("1. early morning is night") { assert-true(is-night(3)) },
    test("1. six o'clock is day") { assert-false(is-night(6)) },
    test("1. the afternoon is day") { assert-false(is-night(15)) },
    test("2. a passenger with a ticket boards") { assert-true(can-board(True, False, False)) },
    test("2. a passenger with a pass boards") { assert-true(can-board(False, True, False)) },
    test("2. a passenger with neither stays behind") { assert-false(can-board(False, False, False)) },
    test("2. a banned passenger stays behind even with a ticket") { assert-false(can-board(True, True, True)) },
    test("3. a toddler travels free") { assert-equal(0, fare(3)) },
    test("3. a child pays the child fare") { assert-equal(20, fare(4)) },
    test("3. a teenager pays the full fare at sixteen") { assert-equal(40, fare(16)) },
    test("3. an adult pays the full fare") { assert-equal(40, fare(64)) },
    test("3. a senior pays the senior fare") { assert-equal(25, fare(65)) },
    test("4. a seat for an adult") { assert-equal(40, ticket-price(30, False)) },
    test("4. a sleeper for an adult") { assert-equal(70, ticket-price(30, True)) },
    test("4. a sleeper for a toddler") { assert-equal(30, ticket-price(2, True)) },
    test("4. a seat for a senior") { assert-equal(25, ticket-price(80, False)) },
  ])
