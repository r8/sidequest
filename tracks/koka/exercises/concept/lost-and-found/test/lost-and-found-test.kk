import test
import lost-and-found

val shelf = ["umbrella", "scarf", "violin"]

pub fun main()
  run([
    test("1. a legible ticket") { assert-equal(Just(12), ticket-number("12")) },
    test("1. slot zero") { assert-equal(Just(0), ticket-number("0")) },
    test("1. a word is not a number") { assert-equal(Nothing, ticket-number("twelve")) },
    test("1. a negative number names no slot") { assert-equal(Nothing, ticket-number("-3")) },
    test("1. a blank ticket") { assert-equal(Nothing, ticket-number("")) },
    test("2. the first of several items") { assert-equal("umbrella", first-item(shelf)) },
    test("2. the only item") { assert-equal("violin", first-item(["violin"])) },
    test("2. an empty shelf") { assert-equal("empty shelf", first-item([])) },
    test("3. a known owner") { assert-equal("Owner: Ada", owner-label(Just("Ada"))) },
    test("3. another known owner") { assert-equal("Owner: Grace Hopper", owner-label(Just("Grace Hopper"))) },
    test("3. an unknown owner") { assert-equal("Owner unknown", owner-label(Nothing)) },
    test("4. claiming the last item") { assert-equal(Just("violin"), claim(shelf, "2")) },
    test("4. claiming the first item") { assert-equal(Just("umbrella"), claim(shelf, "0")) },
    test("4. a slot past the end") { assert-equal(Nothing, claim(shelf, "3")) },
    test("4. an illegible ticket") { assert-equal(Nothing, claim(shelf, "2b")) },
    test("4. a negative ticket") { assert-equal(Nothing, claim(shelf, "-1")) },
  ])
