import test
import resistor-color-trio

pub fun main()
  run([
    test("Orange and orange and black") { assert-equal("33 ohms", label([Orange, Orange, Black])) },
    test("Blue and grey and brown") { assert-equal("680 ohms", label([Blue, Grey, Brown])) },
    test("Red and black and red") { assert-equal("2 kiloohms", label([Red, Black, Red])) },
    test("Green and brown and orange") { assert-equal("51 kiloohms", label([Green, Brown, Orange])) },
    test("Yellow and violet and yellow") { assert-equal("470 kiloohms", label([Yellow, Violet, Yellow])) },
    test("Blue and violet and blue") { assert-equal("67 megaohms", label([Blue, Violet, Blue])) },
    test("Minimum possible value") { assert-equal("0 ohms", label([Black, Black, Black])) },
    test("Maximum possible value") { assert-equal("99 gigaohms", label([White, White, White])) },
    test("First two colors make an invalid octal number") { assert-equal("8 ohms", label([Black, Grey, Black])) },
    test("Ignore extra colors") { assert-equal("650 kiloohms", label([Blue, Green, Yellow, Orange])) },
  ])
