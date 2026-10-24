import std/num/float64
import test
import bakery-batches

pub fun main()
  run([
    test("1. one roll needs a whole tray") { assert-equal(1, trays-needed(1)) },
    test("1. a full tray") { assert-equal(1, trays-needed(12)) },
    test("1. one roll more than a tray") { assert-equal(2, trays-needed(13)) },
    test("1. a large order") { assert-equal(9, trays-needed(100)) },
    test("2. a full tray leaves no places") { assert-equal(0, spare-places(24)) },
    test("2. one roll leaves eleven places") { assert-equal(11, spare-places(1)) },
    test("2. a large order") { assert-equal(8, spare-places(100)) },
    test("3. flour for one roll") { assert-equal(0.125, flour-kg(1)) },
    test("3. flour for a tray") { assert-equal(1.5, flour-kg(12)) },
    test("3. flour for a large order") { assert-equal(12.5, flour-kg(100)) },
    test("4. an even average") { assert-equal(30.0, daily-average(90, 3)) },
    test("4. an average with a fraction") { assert-equal(12.5, daily-average(25, 2)) },
    test("4. fewer rolls than days") { assert-equal(0.25, daily-average(1, 4)) },
    test("5. a price in whole euros") { assert-equal(3, order-price(4)) },
    test("5. a price rounded up") { assert-equal(4, order-price(5)) },
    test("5. a price just under a euro") { assert-equal(1, order-price(1)) },
    test("5. a large order") { assert-equal(75, order-price(100)) },
  ])
