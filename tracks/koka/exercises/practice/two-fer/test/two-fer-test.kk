import test
import two-fer

pub fun main()
  run([
    test("no name given") { assert-equal("One for you, one for me.", two-fer()) },
    test("a name given") { assert-equal("One for Alice, one for me.", two-fer("Alice")) },
    test("another name given") { assert-equal("One for Bob, one for me.", two-fer("Bob")) },
  ])
