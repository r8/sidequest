import test
import knapsack

pub fun main()
  run([
    test("no items") { assert-equal(0, maximum-value(100, [])) },
    test("one item, too heavy") { assert-equal(0, maximum-value(10, [Item(100, 1)])) },
    test("five items (cannot be greedy by weight)") { assert-equal(21, maximum-value(10, [Item(2, 5), Item(2, 5), Item(2, 5), Item(2, 5), Item(10, 21)])) },
    test("five items (cannot be greedy by value)") { assert-equal(80, maximum-value(10, [Item(2, 20), Item(2, 20), Item(2, 20), Item(2, 20), Item(10, 50)])) },
    test("example knapsack") { assert-equal(90, maximum-value(10, [Item(5, 10), Item(4, 40), Item(6, 30), Item(4, 50)])) },
    test("8 items") { assert-equal(900, maximum-value(104, [Item(25, 350), Item(35, 400), Item(45, 450), Item(5, 20), Item(25, 70), Item(3, 8), Item(2, 5), Item(2, 5)])) },
    test("15 items") { assert-equal(1458, maximum-value(750, [Item(70, 135), Item(73, 139), Item(77, 149), Item(80, 150), Item(82, 156), Item(87, 163), Item(90, 173), Item(94, 184), Item(98, 192), Item(106, 201), Item(110, 210), Item(113, 214), Item(115, 221), Item(118, 229), Item(120, 240)])) },
  ])
