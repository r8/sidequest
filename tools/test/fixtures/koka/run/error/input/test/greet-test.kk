import test
import greet

pub fun main()
  run([
    test("stub throws") { assert-equal("Hello, you!", greet()) },
    test("booleans") { assert-true(1 < 2) },
  ])
