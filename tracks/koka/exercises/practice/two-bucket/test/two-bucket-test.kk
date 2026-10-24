import test
import two-bucket

pub fun main()
  run([
    test("Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one") { assert-equal(Measurement(4, One, 5), measure(3, 5, 1, One)) },
    test("Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two") { assert-equal(Measurement(8, Two, 3), measure(3, 5, 1, Two)) },
    test("Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one") { assert-equal(Measurement(14, One, 11), measure(7, 11, 2, One)) },
    test("Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two") { assert-equal(Measurement(18, Two, 7), measure(7, 11, 2, Two)) },
    test("Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two") { assert-equal(Measurement(1, Two, 0), measure(1, 3, 3, Two)) },
    test("Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two") { assert-equal(Measurement(2, Two, 2), measure(2, 3, 3, One)) },
    test("Measure using bucket one much bigger than bucket two") { assert-equal(Measurement(6, One, 1), measure(5, 1, 2, One)) },
    test("Measure using bucket one much smaller than bucket two") { assert-equal(Measurement(6, Two, 0), measure(3, 15, 9, One)) },
    test("Not possible to reach the goal") { assert-throws("impossible") { measure(6, 15, 5, One) } },
    test("With the same buckets but a different goal, then it is possible") { assert-equal(Measurement(10, Two, 0), measure(6, 15, 9, One)) },
    test("Goal larger than both buckets is impossible") { assert-throws("impossible") { measure(5, 7, 8, One) } },
  ])
