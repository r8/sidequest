import test
import nth-prime

pub fun main()
  run([
    test("first prime") { assert-equal(2, prime(1)) },
    test("second prime") { assert-equal(3, prime(2)) },
    test("sixth prime") { assert-equal(13, prime(6)) },
    test("big prime") { assert-equal(104743, prime(10001)) },
    test("there is no zeroth prime") { assert-throws("there is no zeroth prime") { prime(0) } },
  ])
