(import test :as t)
(import ../custom-set :as sol)

(t/deftest "sets with no elements are empty"
  (t/assert-true (sol/empty-set? (sol/make-set []))))

(t/deftest "sets with elements are not empty"
  (t/assert-false (sol/empty-set? (sol/make-set [1]))))

(t/deftest "nothing is contained in an empty set"
  (t/assert-false (sol/contains? (sol/make-set []) 1)))

(t/deftest "when the element is in the set"
  (t/assert-true (sol/contains? (sol/make-set [1 2 3]) 1)))

(t/deftest "when the element is not in the set"
  (t/assert-false (sol/contains? (sol/make-set [1 2 3]) 4)))

(t/deftest "empty set is a subset of another empty set"
  (t/assert-true (sol/subset? (sol/make-set []) (sol/make-set []))))

(t/deftest "empty set is a subset of non-empty set"
  (t/assert-true (sol/subset? (sol/make-set []) (sol/make-set [1]))))

(t/deftest "non-empty set is not a subset of empty set"
  (t/assert-false (sol/subset? (sol/make-set [1]) (sol/make-set []))))

(t/deftest "set is a subset of set with exact same elements"
  (t/assert-true (sol/subset? (sol/make-set [1 2 3]) (sol/make-set [1 2 3]))))

(t/deftest "set is a subset of larger set with same elements"
  (t/assert-true (sol/subset? (sol/make-set [1 2 3]) (sol/make-set [4 1 2 3]))))

(t/deftest "set is not a subset of set that does not contain its elements"
  (t/assert-false (sol/subset? (sol/make-set [1 2 3]) (sol/make-set [4 1 3]))))

(t/deftest "the empty set is disjoint with itself"
  (t/assert-true (sol/disjoint? (sol/make-set []) (sol/make-set []))))

(t/deftest "empty set is disjoint with non-empty set"
  (t/assert-true (sol/disjoint? (sol/make-set []) (sol/make-set [1]))))

(t/deftest "non-empty set is disjoint with empty set"
  (t/assert-true (sol/disjoint? (sol/make-set [1]) (sol/make-set []))))

(t/deftest "sets are not disjoint if they share an element"
  (t/assert-false (sol/disjoint? (sol/make-set [1 2]) (sol/make-set [2 3]))))

(t/deftest "sets are disjoint if they share no elements"
  (t/assert-true (sol/disjoint? (sol/make-set [1 2]) (sol/make-set [3 4]))))

(t/deftest "empty sets are equal"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/make-set []))))

(t/deftest "empty set is not equal to non-empty set"
  (t/assert-false (sol/equal? (sol/make-set []) (sol/make-set [1 2 3]))))

(t/deftest "non-empty set is not equal to empty set"
  (t/assert-false (sol/equal? (sol/make-set [1 2 3]) (sol/make-set []))))

(t/deftest "sets with the same elements are equal"
  (t/assert-true (sol/equal? (sol/make-set [1 2]) (sol/make-set [2 1]))))

(t/deftest "sets with different elements are not equal"
  (t/assert-false (sol/equal? (sol/make-set [1 2 3]) (sol/make-set [1 2 4]))))

(t/deftest "set is not equal to larger set with same elements"
  (t/assert-false (sol/equal? (sol/make-set [1 2 3]) (sol/make-set [1 2 3 4]))))

(t/deftest "set is equal to a set constructed from an array with duplicates"
  (t/assert-true (sol/equal? (sol/make-set [1]) (sol/make-set [1 1]))))

(t/deftest "add to empty set"
  (t/assert-true (sol/equal? (sol/make-set [3]) (sol/add (sol/make-set []) 3))))

(t/deftest "add to non-empty set"
  (t/assert-true (sol/equal? (sol/make-set [1 2 3 4]) (sol/add (sol/make-set [1 2 4]) 3))))

(t/deftest "adding an existing element does not change the set"
  (t/assert-true (sol/equal? (sol/make-set [1 2 3]) (sol/add (sol/make-set [1 2 3]) 3))))

(t/deftest "intersection of two empty sets is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/intersection (sol/make-set []) (sol/make-set [])))))

(t/deftest "intersection of an empty set and non-empty set is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/intersection (sol/make-set []) (sol/make-set [3 2 5])))))

(t/deftest "intersection of a non-empty set and an empty set is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/intersection (sol/make-set [1 2 3 4]) (sol/make-set [])))))

(t/deftest "intersection of two sets with no shared elements is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/intersection (sol/make-set [1 2 3]) (sol/make-set [4 5 6])))))

(t/deftest "intersection of two sets with shared elements is a set of the shared elements"
  (t/assert-true (sol/equal? (sol/make-set [2 3]) (sol/intersection (sol/make-set [1 2 3 4]) (sol/make-set [3 2 5])))))

(t/deftest "difference of two empty sets is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/difference (sol/make-set []) (sol/make-set [])))))

(t/deftest "difference of empty set and non-empty set is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/difference (sol/make-set []) (sol/make-set [3 2 5])))))

(t/deftest "difference of a non-empty set and an empty set is the non-empty set"
  (t/assert-true (sol/equal? (sol/make-set [1 2 3 4]) (sol/difference (sol/make-set [1 2 3 4]) (sol/make-set [])))))

(t/deftest "difference of two non-empty sets is a set of elements that are only in the first set"
  (t/assert-true (sol/equal? (sol/make-set [1 3]) (sol/difference (sol/make-set [3 2 1]) (sol/make-set [2 4])))))

(t/deftest "difference removes all duplicates in the first set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/difference (sol/make-set [1 1]) (sol/make-set [1])))))

(t/deftest "union of empty sets is an empty set"
  (t/assert-true (sol/equal? (sol/make-set []) (sol/union (sol/make-set []) (sol/make-set [])))))

(t/deftest "union of an empty set and non-empty set is the non-empty set"
  (t/assert-true (sol/equal? (sol/make-set [2]) (sol/union (sol/make-set []) (sol/make-set [2])))))

(t/deftest "union of a non-empty set and empty set is the non-empty set"
  (t/assert-true (sol/equal? (sol/make-set [1 3]) (sol/union (sol/make-set [1 3]) (sol/make-set [])))))

(t/deftest "union of non-empty sets contains all unique elements"
  (t/assert-true (sol/equal? (sol/make-set [3 2 1]) (sol/union (sol/make-set [1 3]) (sol/make-set [2 3])))))

(t/run)
