import test
import pangram

pub fun main()
  run([
    test("empty sentence") { assert-false(is-pangram("")) },
    test("perfect lower case") { assert-true(is-pangram("abcdefghijklmnopqrstuvwxyz")) },
    test("only lower case") { assert-true(is-pangram("the quick brown fox jumps over the lazy dog")) },
    test("missing the letter 'x'") { assert-false(is-pangram("a quick movement of the enemy will jeopardize five gunboats")) },
    test("missing the letter 'h'") { assert-false(is-pangram("five boxing wizards jump quickly at it")) },
    test("with underscores") { assert-true(is-pangram("the_quick_brown_fox_jumps_over_the_lazy_dog")) },
    test("with numbers") { assert-true(is-pangram("the 1 quick brown fox jumps over the 2 lazy dogs")) },
    test("missing letters replaced by numbers") { assert-false(is-pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")) },
    test("mixed case and punctuation") { assert-true(is-pangram("\"Five quacking Zephyrs jolt my wax bed.\"")) },
    test("a-m and A-M are 26 different characters but not a pangram") { assert-false(is-pangram("abcdefghijklm ABCDEFGHIJKLM")) },
  ])
