import test
import collatz-conjecture

pub fun main()
  run([
    test("zero steps for one") { assert-equal(0, steps(1)) },
    test("divide if even") { assert-equal(4, steps(16)) },
    test("even and odd steps") { assert-equal(9, steps(12)) },
    test("large number of even and odd steps") { assert-equal(152, steps(1000000)) },
    test("zero is an error") { assert-throws("Only positive integers are allowed") { steps(0) } },
    test("negative value is an error") { assert-throws("Only positive integers are allowed") { steps(-15) } },
  ])
