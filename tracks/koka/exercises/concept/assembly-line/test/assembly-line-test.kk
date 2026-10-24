import test
import assembly-line

pub fun main()
  run([
    test("1. a total station") { assert-equal([10, 20, 30], process-all([1, 2, 3], fn(n) n * 10)) },
    test("1. a station that changes the type") {
      assert-equal(["1", "2"], process-all([1, 2], fn(n) n.show))
    },
    test("1. a station that throws") {
      assert-throws("out of paint") {
        process-all([1, 2, 3], fn(n) if n == 3 then throw("out of paint") else n)
      }
    },
    test("1. a station that does not throw on this batch") {
      assert-equal([1, 2], process-all([1, 2], fn(n) if n == 3 then throw("out of paint") else n))
    },
    test("2. stations run in order") {
      assert-equal("train painted boxed", pipeline("train", [fn(s) s ++ " painted", fn(s) s ++ " boxed"]))
    },
    test("2. no stations") { assert-equal(5, pipeline(5, [])) },
    test("2. arithmetic stations") { assert-equal(7, pipeline(2, [fn(n) n * 3, fn(n) n + 1])) },
    test("2. a station that throws") {
      assert-throws("jammed") { pipeline(1, [fn(n) n + 1, fn(_) throw("jammed"), fn(n) n * 2]) }
    },
    test("3. some pass") { assert-equal(2, count-passing([3, -1, 4], fn(n) n > 0)) },
    test("3. none to check") { assert-equal(0, count-passing([], fn(n : int) n > 0)) },
    test("3. a check that throws") {
      assert-throws("scanner broken") { count-passing(["a", "b"], fn(s) if s == "b" then throw("scanner broken") else True) }
    },
    test("4. a wheel within the limits") { assert-equal(12, inspect-wheel(12)) },
    test("4. the narrowest wheel") { assert-equal(10, inspect-wheel(10)) },
    test("4. the widest wheel") { assert-equal(20, inspect-wheel(20)) },
    test("4. a wheel too narrow") { assert-throws("defective wheel") { inspect-wheel(9) } },
    test("4. a wheel too wide") { assert-throws("defective wheel") { inspect-wheel(21) } },
    test("5. the first defect") { assert-equal(Just(-1), first-defect([3, -1, 4, -5], fn(n) n > 0)) },
    test("5. no defects") { assert-equal(Nothing, first-defect([3, 4], fn(n) n > 0)) },
    test("5. checking stops at the first defect") {
      assert-equal(Just(-2), first-defect([1, -2, 3], fn(n) if n == 3 then throw("checked too far") else n > 0))
    },
    test("5. using inspect-wheel as a check") {
      assert-throws("defective wheel") { first-defect([12, 30], fn(w) inspect-wheel(w) > 0) }
    },
  ])
