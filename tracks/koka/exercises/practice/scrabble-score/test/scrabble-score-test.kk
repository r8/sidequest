import test
import scrabble-score

pub fun main()
  run([
    test("lowercase letter") { assert-equal(1, score("a")) },
    test("uppercase letter") { assert-equal(1, score("A")) },
    test("valuable letter") { assert-equal(4, score("f")) },
    test("short word") { assert-equal(2, score("at")) },
    test("short, valuable word") { assert-equal(12, score("zoo")) },
    test("medium word") { assert-equal(6, score("street")) },
    test("medium, valuable word") { assert-equal(22, score("quirky")) },
    test("long, mixed-case word") { assert-equal(41, score("OxyphenButazone")) },
    test("english-like word") { assert-equal(8, score("pinata")) },
    test("empty input") { assert-equal(0, score("")) },
    test("entire alphabet available") { assert-equal(87, score("abcdefghijklmnopqrstuvwxyz")) },
  ])
