import test
import rotational-cipher

pub fun main()
  run([
    test("rotate a by 0, same output as input") { assert-equal("a", rotate("a", 0)) },
    test("rotate a by 1") { assert-equal("b", rotate("a", 1)) },
    test("rotate a by 26, same output as input") { assert-equal("a", rotate("a", 26)) },
    test("rotate m by 13") { assert-equal("z", rotate("m", 13)) },
    test("rotate n by 13 with wrap around alphabet") { assert-equal("a", rotate("n", 13)) },
    test("rotate capital letters") { assert-equal("TRL", rotate("OMG", 5)) },
    test("rotate spaces") { assert-equal("T R L", rotate("O M G", 5)) },
    test("rotate numbers") { assert-equal("Xiwxmrk 1 2 3 xiwxmrk", rotate("Testing 1 2 3 testing", 4)) },
    test("rotate punctuation") { assert-equal("Gzo'n zvo, Bmviyhv!", rotate("Let's eat, Grandma!", 21)) },
    test("rotate all letters") { assert-equal("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", rotate("The quick brown fox jumps over the lazy dog.", 13)) },
  ])
