import test
import custom-set

pub fun main()
  run([
    test("Returns true if the set contains no elements > sets with no elements are empty") {
      assert-true(from-list([] : list<int>).is-empty)
    },
    test("Returns true if the set contains no elements > sets with elements are not empty") {
      assert-false(from-list([1]).is-empty)
    },
    test("Sets can report if they contain an element > nothing is contained in an empty set") {
      assert-false(from-list([] : list<int>).contains(1))
    },
    test("Sets can report if they contain an element > when the element is in the set") {
      assert-true(from-list([1, 2, 3]).contains(1))
    },
    test("Sets can report if they contain an element > when the element is not in the set") {
      assert-false(from-list([1, 2, 3]).contains(4))
    },
    test("A set is a subset if all of its elements are contained in the other set > empty set is a subset of another empty set") {
      assert-true(from-list([] : list<int>).is-subset(from-list([] : list<int>)))
    },
    test("A set is a subset if all of its elements are contained in the other set > empty set is a subset of non-empty set") {
      assert-true(from-list([] : list<int>).is-subset(from-list([1])))
    },
    test("A set is a subset if all of its elements are contained in the other set > non-empty set is not a subset of empty set") {
      assert-false(from-list([1]).is-subset(from-list([] : list<int>)))
    },
    test("A set is a subset if all of its elements are contained in the other set > set is a subset of set with exact same elements") {
      assert-true(from-list([1, 2, 3]).is-subset(from-list([1, 2, 3])))
    },
    test("A set is a subset if all of its elements are contained in the other set > set is a subset of larger set with same elements") {
      assert-true(from-list([1, 2, 3]).is-subset(from-list([4, 1, 2, 3])))
    },
    test("A set is a subset if all of its elements are contained in the other set > set is not a subset of set that does not contain its elements") {
      assert-false(from-list([1, 2, 3]).is-subset(from-list([4, 1, 3])))
    },
    test("Sets are disjoint if they share no elements > the empty set is disjoint with itself") {
      assert-true(from-list([] : list<int>).is-disjoint(from-list([] : list<int>)))
    },
    test("Sets are disjoint if they share no elements > empty set is disjoint with non-empty set") {
      assert-true(from-list([] : list<int>).is-disjoint(from-list([1])))
    },
    test("Sets are disjoint if they share no elements > non-empty set is disjoint with empty set") {
      assert-true(from-list([1]).is-disjoint(from-list([] : list<int>)))
    },
    test("Sets are disjoint if they share no elements > sets are not disjoint if they share an element") {
      assert-false(from-list([1, 2]).is-disjoint(from-list([2, 3])))
    },
    test("Sets are disjoint if they share no elements > sets are disjoint if they share no elements") {
      assert-true(from-list([1, 2]).is-disjoint(from-list([3, 4])))
    },
    test("Sets with the same elements are equal > empty sets are equal") {
      assert-true(from-list([] : list<int>).is-equal(from-list([] : list<int>)))
    },
    test("Sets with the same elements are equal > empty set is not equal to non-empty set") {
      assert-false(from-list([] : list<int>).is-equal(from-list([1, 2, 3])))
    },
    test("Sets with the same elements are equal > non-empty set is not equal to empty set") {
      assert-false(from-list([1, 2, 3]).is-equal(from-list([] : list<int>)))
    },
    test("Sets with the same elements are equal > sets with the same elements are equal") {
      assert-true(from-list([1, 2]).is-equal(from-list([2, 1])))
    },
    test("Sets with the same elements are equal > sets with different elements are not equal") {
      assert-false(from-list([1, 2, 3]).is-equal(from-list([1, 2, 4])))
    },
    test("Sets with the same elements are equal > set is not equal to larger set with same elements") {
      assert-false(from-list([1, 2, 3]).is-equal(from-list([1, 2, 3, 4])))
    },
    test("Sets with the same elements are equal > set is equal to a set constructed from an array with duplicates") {
      assert-true(from-list([1]).is-equal(from-list([1, 1])))
    },
    test("Unique elements can be added to a set > add to empty set") {
      assert-equal([3], from-list([] : list<int>).add(3).to-list)
    },
    test("Unique elements can be added to a set > add to non-empty set") {
      assert-equal([1, 2, 3, 4], from-list([1, 2, 4]).add(3).to-list)
    },
    test("Unique elements can be added to a set > adding an existing element does not change the set") {
      assert-equal([1, 2, 3], from-list([1, 2, 3]).add(3).to-list)
    },
    test("Intersection returns a set of all shared elements > intersection of two empty sets is an empty set") {
      assert-equal([], from-list([] : list<int>).intersection(from-list([] : list<int>)).to-list)
    },
    test("Intersection returns a set of all shared elements > intersection of an empty set and non-empty set is an empty set") {
      assert-equal([], from-list([] : list<int>).intersection(from-list([3, 2, 5])).to-list)
    },
    test("Intersection returns a set of all shared elements > intersection of a non-empty set and an empty set is an empty set") {
      assert-equal([], from-list([1, 2, 3, 4]).intersection(from-list([] : list<int>)).to-list)
    },
    test("Intersection returns a set of all shared elements > intersection of two sets with no shared elements is an empty set") {
      assert-equal([], from-list([1, 2, 3]).intersection(from-list([4, 5, 6])).to-list)
    },
    test("Intersection returns a set of all shared elements > intersection of two sets with shared elements is a set of the shared elements") {
      assert-equal([2, 3], from-list([1, 2, 3, 4]).intersection(from-list([3, 2, 5])).to-list)
    },
    test("Difference (or Complement) of a set is a set of all elements that are only in the first set > difference of two empty sets is an empty set") {
      assert-equal([], from-list([] : list<int>).difference(from-list([] : list<int>)).to-list)
    },
    test("Difference (or Complement) of a set is a set of all elements that are only in the first set > difference of empty set and non-empty set is an empty set") {
      assert-equal([], from-list([] : list<int>).difference(from-list([3, 2, 5])).to-list)
    },
    test("Difference (or Complement) of a set is a set of all elements that are only in the first set > difference of a non-empty set and an empty set is the non-empty set") {
      assert-equal([1, 2, 3, 4], from-list([1, 2, 3, 4]).difference(from-list([] : list<int>)).to-list)
    },
    test("Difference (or Complement) of a set is a set of all elements that are only in the first set > difference of two non-empty sets is a set of elements that are only in the first set") {
      assert-equal([1, 3], from-list([3, 2, 1]).difference(from-list([2, 4])).to-list)
    },
    test("Difference (or Complement) of a set is a set of all elements that are only in the first set > difference removes all duplicates in the first set") {
      assert-equal([], from-list([1, 1]).difference(from-list([1])).to-list)
    },
    test("Union returns a set of all elements in either set > union of empty sets is an empty set") {
      assert-equal([], from-list([] : list<int>).union(from-list([] : list<int>)).to-list)
    },
    test("Union returns a set of all elements in either set > union of an empty set and non-empty set is the non-empty set") {
      assert-equal([2], from-list([] : list<int>).union(from-list([2])).to-list)
    },
    test("Union returns a set of all elements in either set > union of a non-empty set and empty set is the non-empty set") {
      assert-equal([1, 3], from-list([1, 3]).union(from-list([] : list<int>)).to-list)
    },
    test("Union returns a set of all elements in either set > union of non-empty sets contains all unique elements") {
      assert-equal([1, 2, 3], from-list([1, 3]).union(from-list([2, 3])).to-list)
    },
  ])
