import test
import zebra-puzzle

pub fun main()
  run([
    test("resident who drinks water") { assert-equal("Norwegian", drinks-water()) },
    test("resident who owns zebra") { assert-equal("Japanese", owns-zebra()) },
  ])
