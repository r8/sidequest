import test
import perfect-numbers

pub fun main()
  run([
    test("Perfect numbers > Smallest perfect number is classified correctly") { assert-equal(Perfect, classify(6)) },
    test("Perfect numbers > Medium perfect number is classified correctly") { assert-equal(Perfect, classify(28)) },
    test("Perfect numbers > Large perfect number is classified correctly") { assert-equal(Perfect, classify(33550336)) },
    test("Abundant numbers > Smallest abundant number is classified correctly") { assert-equal(Abundant, classify(12)) },
    test("Abundant numbers > Medium abundant number is classified correctly") { assert-equal(Abundant, classify(30)) },
    test("Abundant numbers > Large abundant number is classified correctly") { assert-equal(Abundant, classify(33550335)) },
    test("Abundant numbers > Perfect square abundant number is classified correctly") { assert-equal(Abundant, classify(196)) },
    test("Deficient numbers > Smallest prime deficient number is classified correctly") { assert-equal(Deficient, classify(2)) },
    test("Deficient numbers > Smallest non-prime deficient number is classified correctly") { assert-equal(Deficient, classify(4)) },
    test("Deficient numbers > Medium deficient number is classified correctly") { assert-equal(Deficient, classify(32)) },
    test("Deficient numbers > Large deficient number is classified correctly") { assert-equal(Deficient, classify(33550337)) },
    test("Deficient numbers > Edge case (no factors other than itself) is classified correctly") { assert-equal(Deficient, classify(1)) },
    test("Invalid inputs > Zero is rejected (as it is not a positive integer)") { assert-throws("Classification is only possible for positive integers.") { classify(0) } },
    test("Invalid inputs > Negative integer is rejected (as it is not a positive integer)") { assert-throws("Classification is only possible for positive integers.") { classify(-1) } },
  ])
