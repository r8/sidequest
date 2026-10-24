import test
import coffee-cart

pub fun main()
  run([
    test("1. a small cup") { assert-equal(250, cup-price(Small)) },
    test("1. a medium cup") { assert-equal(300, cup-price(Medium)) },
    test("1. a large cup") { assert-equal(350, cup-price(Large)) },
    test("2. an espresso") { assert-equal(200, price(Espresso)) },
    test("2. a latte") { assert-equal(300, price(Latte(Medium, False))) },
    test("2. a latte with oat milk") { assert-equal(400, price(Latte(Large, True))) },
    test("2. a tea") { assert-equal(200, price(Tea("mint", Small))) },
    test("3. an espresso's cup") { assert-equal("espresso", label(Espresso)) },
    test("3. a latte's cup") { assert-equal("medium latte", label(Latte(Medium, False))) },
    test("3. an oat latte's cup") { assert-equal("small latte with oat milk", label(Latte(Small, True))) },
    test("3. a tea's cup") { assert-equal("large mint tea", label(Tea("mint", Large))) },
    test("4. a small tea becomes medium") { assert-equal(Tea("rooibos", Medium), upsize(Tea("rooibos", Small))) },
    test("4. a medium latte becomes large and keeps its milk") {
      assert-equal(Latte(Large, True), upsize(Latte(Medium, True)))
    },
    test("4. a large drink stays large") { assert-equal(Latte(Large, False), upsize(Latte(Large, False))) },
    test("4. an espresso stays an espresso") { assert-equal(Espresso, upsize(Espresso)) },
    test("5. a latte with cow's milk") { assert-true(needs-milk(Latte(Medium, False))) },
    test("5. a latte with oat milk") { assert-false(needs-milk(Latte(Small, True))) },
    test("5. a tea") { assert-false(needs-milk(Tea("green", Large))) },
    test("5. an espresso") { assert-false(needs-milk(Espresso)) },
  ])
