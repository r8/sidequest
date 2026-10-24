import test
import secret-handshake

pub fun main()
  run([
    test("wink for 1") { assert-equal([Wink], commands(1)) },
    test("double blink for 10") { assert-equal([DoubleBlink], commands(2)) },
    test("close your eyes for 100") { assert-equal([CloseYourEyes], commands(4)) },
    test("jump for 1000") { assert-equal([Jump], commands(8)) },
    test("combine two actions") { assert-equal([Wink, DoubleBlink], commands(3)) },
    test("reverse two actions") { assert-equal([DoubleBlink, Wink], commands(19)) },
    test("reversing one action gives the same action") { assert-equal([Jump], commands(24)) },
    test("reversing no actions still gives no actions") { assert-equal([], commands(16)) },
    test("all possible actions") { assert-equal([Wink, DoubleBlink, CloseYourEyes, Jump], commands(15)) },
    test("reverse all possible actions") { assert-equal([Jump, CloseYourEyes, DoubleBlink, Wink], commands(31)) },
    test("do nothing for zero") { assert-equal([], commands(0)) },
  ])
