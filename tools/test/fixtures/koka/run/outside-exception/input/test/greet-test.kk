import test
import greet

pub fun main()
  val x : int = throw("setup failed")
  run([test("never") { assert-equal("Hello, you!", greet()) }])
