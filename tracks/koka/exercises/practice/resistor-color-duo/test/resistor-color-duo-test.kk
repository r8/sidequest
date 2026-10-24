import test
import resistor-color-duo

pub fun main()
  run([
    test("Brown and black") { assert-equal(10, value([Brown, Black])) },
    test("Blue and grey") { assert-equal(68, value([Blue, Grey])) },
    test("Yellow and violet") { assert-equal(47, value([Yellow, Violet])) },
    test("White and red") { assert-equal(92, value([White, Red])) },
    test("Orange and orange") { assert-equal(33, value([Orange, Orange])) },
    test("Ignore additional colors") { assert-equal(51, value([Green, Brown, Orange])) },
    test("Black and brown, one-digit") { assert-equal(1, value([Black, Brown])) },
  ])
