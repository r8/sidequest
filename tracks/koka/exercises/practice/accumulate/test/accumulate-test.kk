import test
import accumulate

pub fun main()
  run([
    test("accumulate empty") { assert-equal([], accumulate([] : list<int>, fn(x) x * x)) },
    test("accumulate squares") { assert-equal([1, 4, 9], accumulate([1, 2, 3], fn(x) x * x)) },
    test("accumulate upcases") { assert-equal(["HELLO", "WORLD"], accumulate(["Hello", "world"], to-upper)) },
    test("accumulate reversed strings") {
      assert-equal(["eht", "kciuq", "nworb", "xof", "cte"],
                   accumulate(["the", "quick", "brown", "fox", "etc"], fn(s) s.list.reverse.string))
    },
    test("accumulate recursively") {
      assert-equal([["a1", "a2", "a3"], ["b1", "b2", "b3"], ["c1", "c2", "c3"]],
                   accumulate(["a", "b", "c"], fn(x) accumulate(["1", "2", "3"], fn(y) x ++ y)))
    },
  ])
