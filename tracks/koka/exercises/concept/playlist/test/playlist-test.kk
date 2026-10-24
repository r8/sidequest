import test
import playlist

pub fun main()
  run([
    test("1. queue a song next") { assert-equal(["Gold", "Blue", "Red"], queue-next(["Blue", "Red"], "Gold")) },
    test("1. queue a song next on an empty playlist") { assert-equal(["Gold"], queue-next([], "Gold")) },
    test("1. queue a song next that is already queued") { assert-equal(["Red", "Blue", "Red"], queue-next(["Blue", "Red"], "Red")) },
    test("2. queue a song last") { assert-equal(["Blue", "Red", "Gold"], queue-last(["Blue", "Red"], "Gold")) },
    test("2. queue a song last on an empty playlist") { assert-equal(["Gold"], queue-last([], "Gold")) },
    test("3. skip one song") { assert-equal(["Red", "Gold"], skip(["Blue", "Red", "Gold"], 1)) },
    test("3. skip no songs") { assert-equal(["Blue", "Red"], skip(["Blue", "Red"], 0)) },
    test("3. skip more songs than there are") { assert-equal([], skip(["Blue", "Red"], 5)) },
    test("4. a song on the playlist") { assert-true(has-song(["Blue", "Red", "Gold"], "Red")) },
    test("4. a song not on the playlist") { assert-false(has-song(["Blue", "Red", "Gold"], "Green")) },
    test("4. an empty playlist") { assert-false(has-song([], "Blue")) },
    test("5. three songs") { assert-equal(600, total-seconds([180, 240, 180])) },
    test("5. one song") { assert-equal(215, total-seconds([215])) },
    test("5. no songs") { assert-equal(0, total-seconds([])) },
    test("6. several songs") { assert-equal("3 songs: Blue, Red, Gold", summary(["Blue", "Red", "Gold"])) },
    test("6. one song") { assert-equal("1 song: Blue", summary(["Blue"])) },
    test("6. no songs") { assert-equal("No songs", summary([])) },
  ])
