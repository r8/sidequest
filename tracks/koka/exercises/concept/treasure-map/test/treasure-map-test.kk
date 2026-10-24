import test
import treasure-map

pub fun main()
  run([
    test("1. a step north") { assert-equal((2, 4), move((2, 3), "north")) },
    test("1. a step south") { assert-equal((0, -1), move((0, 0), "south")) },
    test("1. a step east") { assert-equal((-2, 5), move((-3, 5), "east")) },
    test("1. a step west") { assert-equal((3, 3), move((4, 3), "west")) },
    test("1. a smudge keeps you in place") { assert-equal((1, 1), move((1, 1), "North")) },
    test("2. camp") { assert-equal("camp", region((0, 0))) },
    test("2. mountains") { assert-equal("mountains", region((3, 6))) },
    test("2. mountains in the far west") { assert-equal("mountains", region((-4, 9))) },
    test("2. swamp") { assert-equal("swamp", region((-2, 1))) },
    test("2. beach") { assert-equal("beach", region((0, 5))) },
    test("3. no paces to the same spot") { assert-equal(0, paces((2, 2), (2, 2))) },
    test("3. paces along one line") { assert-equal(4, paces((0, 0), (0, 4))) },
    test("3. paces across the island") { assert-equal(7, paces((1, 2), (4, -2))) },
    test("3. paces back again") { assert-equal(7, paces((4, -2), (1, 2))) },
    test("4. no clues") { assert-equal("No clues!", read-clues([])) },
    test("4. one clue") { assert-equal("Only dig!", read-clues(["dig"])) },
    test("4. two clues") { assert-equal("dig then under the palm!", read-clues(["dig", "under the palm"])) },
    test("4. many clues") { assert-equal("dig then 2 more!", read-clues(["dig", "under the palm", "at noon"])) },
  ])
