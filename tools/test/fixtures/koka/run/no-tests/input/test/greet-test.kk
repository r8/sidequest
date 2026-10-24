import test
import greet

// A comment with a paren ( and a "string" that must not confuse extraction.
pub fun main()
  run([
    test("no name") {
      println("noisy\toutput")
      println("second line")
      assert-equal("Hello, you!", greet())
    },
    test("name with \"quotes\"", fn() assert-equal("Hello, \"Bob\"!", greet("\"Bob\""))),
  ])
