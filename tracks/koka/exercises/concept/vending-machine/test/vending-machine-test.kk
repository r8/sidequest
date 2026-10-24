import test
import vending-machine

pub fun main()
  run([
    test("1. change from a sale") { assert-equal(2, vend(3, 5)) },
    test("1. the exact price") { assert-equal(0, vend(4, 4)) },
    test("1. a free item") { assert-equal(3, vend(0, 3)) },
    test("1. not enough money") { assert-throws("not enough money") { vend(3, 2) } },
    test("2. a sale that succeeds") { assert-equal(Just(2), try-vend(3, 5)) },
    test("2. a sale that fails") { assert-equal(Nothing, try-vend(3, 2)) },
    test("2. the exact price") { assert-equal(Just(0), try-vend(1, 1)) },
    test("3. change from a sale") { assert-equal(4, vend-or-refund(6, 10)) },
    test("3. a refund") { assert-equal(2, vend-or-refund(3, 2)) },
    test("3. nothing paid, nothing refunded") { assert-equal(0, vend-or-refund(3, 0)) },
    test("4. the change on the panel") { assert-equal("change: 2", panel-text(3, 5)) },
    test("4. the error on the panel") { assert-equal("error: not enough money", panel-text(3, 2)) },
    test("4. no change on the panel") { assert-equal("change: 0", panel-text(3, 3)) },
    test("5. two items") { assert-equal(2, vend-all([1, 2], 5)) },
    test("5. no items") { assert-equal(5, vend-all([], 5)) },
    test("5. exactly enough") { assert-equal(0, vend-all([2, 2, 1], 5)) },
    test("5. running out") { assert-throws("not enough money") { vend-all([2, 2, 2], 5) } },
  ])
