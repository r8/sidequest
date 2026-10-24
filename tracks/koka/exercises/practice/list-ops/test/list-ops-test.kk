import test
import list-ops
import std/num/float64

pub fun main()
  run([
    test("append entries to a list and return the new list > empty lists") {
      assert-equal([], ops/append([] : list<int>, []))
    },
    test("append entries to a list and return the new list > list to empty list") {
      assert-equal([1, 2, 3, 4], ops/append([], [1, 2, 3, 4]))
    },
    test("append entries to a list and return the new list > empty list to list") {
      assert-equal([1, 2, 3, 4], ops/append([1, 2, 3, 4], []))
    },
    test("append entries to a list and return the new list > non-empty lists") {
      assert-equal([1, 2, 2, 3, 4, 5], ops/append([1, 2], [2, 3, 4, 5]))
    },
    test("concatenate a list of lists > empty list") {
      assert-equal([], ops/concat([] : list<list<int>>))
    },
    test("concatenate a list of lists > list of lists") {
      assert-equal([1, 2, 3, 4, 5, 6], ops/concat([[1, 2], [3], [], [4, 5, 6]]))
    },
    test("concatenate a list of lists > list of nested lists") {
      assert-equal([[1], [2], [3], [], [4, 5, 6]], ops/concat([[[1], [2]], [[3]], [[]], [[4, 5, 6]]]))
    },
    test("filter list returning only values that satisfy the filter function > empty list") {
      assert-equal([], ops/filter([] : list<int>, fn(x) x % 2 == 1))
    },
    test("filter list returning only values that satisfy the filter function > non-empty list") {
      assert-equal([1, 3, 5], ops/filter([1, 2, 3, 5], fn(x) x % 2 == 1))
    },
    test("returns the length of a list > empty list") {
      assert-equal(0, ops/length([] : list<int>))
    },
    test("returns the length of a list > non-empty list") {
      assert-equal(4, ops/length([1, 2, 3, 4]))
    },
    test("return a list of elements whose values equal the list value transformed by the mapping function > empty list") {
      assert-equal([], ops/map([] : list<int>, fn(x) x + 1))
    },
    test("return a list of elements whose values equal the list value transformed by the mapping function > non-empty list") {
      assert-equal([2, 4, 6, 8], ops/map([1, 3, 5, 7], fn(x) x + 1))
    },
    test("folds (reduces) the given list from the left with a function > empty list") {
      assert-equal(2, ops/foldl([], 2, fn(acc, el) el * acc))
    },
    test("folds (reduces) the given list from the left with a function > direction independent function applied to non-empty list") {
      assert-equal(15, ops/foldl([1, 2, 3, 4], 5, fn(acc, el) el + acc))
    },
    test("folds (reduces) the given list from the left with a function > direction dependent function applied to non-empty list") {
      assert-equal(64.0, ops/foldl([1.0, 2.0, 3.0, 4.0], 24.0, fn(acc, el) el / acc))
    },
    test("folds (reduces) the given list from the right with a function > empty list") {
      assert-equal(2, ops/foldr([], 2, fn(el, acc) el * acc))
    },
    test("folds (reduces) the given list from the right with a function > direction independent function applied to non-empty list") {
      assert-equal(15, ops/foldr([1, 2, 3, 4], 5, fn(el, acc) el + acc))
    },
    test("folds (reduces) the given list from the right with a function > direction dependent function applied to non-empty list") {
      assert-equal(9.0, ops/foldr([1.0, 2.0, 3.0, 4.0], 24.0, fn(el, acc) el / acc))
    },
    test("reverse the elements of the list > empty list") {
      assert-equal([], ops/reverse([] : list<int>))
    },
    test("reverse the elements of the list > non-empty even-length list") {
      assert-equal([7, 5, 3, 1], ops/reverse([1, 3, 5, 7]))
    },
    test("reverse the elements of the list > non-empty odd-length list") {
      assert-equal([13, 11, 9, 7, 5, 3, 1], ops/reverse([1, 3, 5, 7, 9, 11, 13]))
    },
    test("reverse the elements of the list > list of lists is not flattened") {
      assert-equal([[4, 5, 6], [], [3], [1, 2]], ops/reverse([[1, 2], [3], [], [4, 5, 6]]))
    },
  ])
