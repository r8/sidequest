import test
import all-your-base

pub fun main()
  run([
    test("single bit one to decimal") { assert-equal([1], rebase(2, [1], 10)) },
    test("binary to single decimal") { assert-equal([5], rebase(2, [1, 0, 1], 10)) },
    test("single decimal to binary") { assert-equal([1, 0, 1], rebase(10, [5], 2)) },
    test("binary to multiple decimal") { assert-equal([4, 2], rebase(2, [1, 0, 1, 0, 1, 0], 10)) },
    test("decimal to binary") { assert-equal([1, 0, 1, 0, 1, 0], rebase(10, [4, 2], 2)) },
    test("trinary to hexadecimal") { assert-equal([2, 10], rebase(3, [1, 1, 2, 0], 16)) },
    test("hexadecimal to trinary") { assert-equal([1, 1, 2, 0], rebase(16, [2, 10], 3)) },
    test("15-bit integer") { assert-equal([6, 10, 45], rebase(97, [3, 46, 60], 73)) },
    test("empty list") { assert-equal([0], rebase(2, [], 10)) },
    test("single zero") { assert-equal([0], rebase(10, [0], 2)) },
    test("multiple zeros") { assert-equal([0], rebase(10, [0, 0, 0], 2)) },
    test("leading zeros") { assert-equal([4, 2], rebase(7, [0, 6, 0], 10)) },
    test("input base is one") { assert-throws("input base must be >= 2") { rebase(1, [0], 10) } },
    test("input base is zero") { assert-throws("input base must be >= 2") { rebase(0, [], 10) } },
    test("input base is negative") { assert-throws("input base must be >= 2") { rebase(-2, [1], 10) } },
    test("negative digit") { assert-throws("all digits must satisfy 0 <= d < input base") { rebase(2, [1, -1, 1, 0, 1, 0], 10) } },
    test("invalid positive digit") { assert-throws("all digits must satisfy 0 <= d < input base") { rebase(2, [1, 2, 1, 0, 1, 0], 10) } },
    test("output base is one") { assert-throws("output base must be >= 2") { rebase(2, [1, 0, 1, 0, 1, 0], 1) } },
    test("output base is zero") { assert-throws("output base must be >= 2") { rebase(10, [7], 0) } },
    test("output base is negative") { assert-throws("output base must be >= 2") { rebase(2, [1], -7) } },
    test("both bases are negative") { assert-throws("input base must be >= 2") { rebase(-2, [1], -7) } },
  ])
