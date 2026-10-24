import test
import hello-world

pub fun main()
  run([
    test("Say Hi!") { assert-equal("Hello, World!", hello()) },
  ])
