import test
import strain

val words = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]

val lists = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]]

pub fun main()
  run([
    test("keep on empty list returns empty list") { assert-equal([], keep([] : list<int>, fn(_) True)) },
    test("keeps everything") { assert-equal([1, 3, 5], keep([1, 3, 5], fn(_) True)) },
    test("keeps nothing") { assert-equal([], keep([1, 3, 5], fn(_) False)) },
    test("keeps first and last") { assert-equal([1, 3], keep([1, 2, 3], fn(x) x % 2 == 1)) },
    test("keeps neither first nor last") { assert-equal([2], keep([1, 2, 3], fn(x) x % 2 == 0)) },
    test("keeps strings") {
      assert-equal(["zebra", "zombies", "zealot"], keep(words, fn(w) w.starts-with("z").is-just))
    },
    test("keeps lists") {
      assert-equal([[5, 5, 5], [5, 1, 2], [1, 5, 2], [1, 2, 5]], keep(lists, fn(xs) xs.contains(5)))
    },
    test("discard on empty list returns empty list") { assert-equal([], discard([] : list<int>, fn(_) True)) },
    test("discards everything") { assert-equal([], discard([1, 3, 5], fn(_) True)) },
    test("discards nothing") { assert-equal([1, 3, 5], discard([1, 3, 5], fn(_) False)) },
    test("discards first and last") { assert-equal([2], discard([1, 2, 3], fn(x) x % 2 == 1)) },
    test("discards neither first nor last") { assert-equal([1, 3], discard([1, 2, 3], fn(x) x % 2 == 0)) },
    test("discards strings") {
      assert-equal(["apple", "banana", "cherimoya"], discard(words, fn(w) w.starts-with("z").is-just))
    },
    test("discards lists") {
      assert-equal([[1, 2, 3], [2, 1, 2], [2, 2, 1]], discard(lists, fn(xs) xs.contains(5)))
    },
  ])
