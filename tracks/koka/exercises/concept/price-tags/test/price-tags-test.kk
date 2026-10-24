import test
import price-tags

pub fun main()
  run([
    test("1. dollars and cents") { assert-equal("$3.05", Money(305).show) },
    test("1. a round amount") { assert-equal("$12.00", Money(1200).show) },
    test("1. less than a dollar") { assert-equal("$0.99", Money(99).show) },
    test("1. nothing at all") { assert-equal("$0.00", Money(0).show) },
    test("2. sold each") { assert-equal("each", Each.show) },
    test("2. sold per kilo") { assert-equal("per kilo", PerKilo.show) },
    test("3. equal amounts") { assert-true(Money(250) == Money(250)) },
    test("3. different amounts") { assert-false(Money(250) == Money(205)) },
    test("3. lists of amounts compare by their elements") {
      assert-true([Money(1), Money(2)] == [Money(1), Money(2)])
    },
    test("4. a smaller amount") { assert-true(cmp(Money(99), Money(250)) == Lt) },
    test("4. a larger amount") { assert-true(cmp(Money(1000), Money(999)) == Gt) },
    test("4. the same amount") { assert-true(cmp(Money(42), Money(42)) == Eq) },
    test("5. a tag with a price") { assert-equal("turnips: $3.05", label("turnips", Money(305))) },
    test("5. a tag with a measure") { assert-equal("sold: per kilo", label("sold", PerKilo)) },
    test("5. a tag with a number") { assert-equal("stock: 12", label("stock", 12)) },
    test("5. a tag with an explicit show") {
      assert-equal("weight: 3 kg", label("weight", 3, ?show = fn(n) n.show ++ " kg"))
    },
    test("6. the cheapest price") {
      assert-equal(Just(99), cheapest([Money(305), Money(99), Money(250)]).map(cents))
    },
    test("6. the smallest number") { assert-equal(Just(1), cheapest([3, 1, 2])) },
    test("6. the first of equal prices") {
      assert-equal(Just("b"), cheapest([("c", 5), ("b", 2), ("a", 2)], ?cmp = fn(x, y) cmp(x.snd, y.snd)).map(fst))
    },
    test("6. nothing to choose from") { assert-equal(Nothing, cheapest([] : list<int>)) },
  ])
