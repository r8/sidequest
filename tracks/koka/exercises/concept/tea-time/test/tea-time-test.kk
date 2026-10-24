import test
import tea-time

pub fun main()
  run([
    test("1. tea steeps for 4 minutes") { assert-equal(4, steep-minutes()) },
    test("2. minutes left for a pot just started") { assert-equal(4, minutes-left(0)) },
    test("2. minutes left for a pot halfway through") { assert-equal(2, minutes-left(2)) },
    test("2. minutes left for a pot about to finish") { assert-equal(1, minutes-left(3)) },
    test("3. boiling water for one cup") { assert-equal(2, boiling-minutes(1)) },
    test("3. boiling water for a full pot") { assert-equal(8, boiling-minutes(4)) },
    test("3. boiling water for a large pot") { assert-equal(14, boiling-minutes(7)) },
    test("4. elapsed minutes for a pot not yet steeping") { assert-equal(4, elapsed-minutes(2, 0)) },
    test("4. elapsed minutes for a pot steeping") { assert-equal(8, elapsed-minutes(3, 2)) },
    test("4. elapsed minutes for a large pot almost done") { assert-equal(13, elapsed-minutes(5, 3)) },
  ])
