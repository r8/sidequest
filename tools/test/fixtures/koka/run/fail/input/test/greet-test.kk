import test
import greet

pub fun main()
  run([
    test("passes") { assert-equal("Hello, you!", greet()) },
    test("fails on a list") { assert-equal([1, 2], [1, 3]) },
    test("fails on a missing exception") { assert-throws("boom") { greet() } },
  ])
