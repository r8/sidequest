(import test :as t)
(import ../flatten-array :as sol)

(t/deftest "empty"
  (t/assert-equal [] (sol/flatten [])))

(t/deftest "no nesting"
  (t/assert-equal [0 1 2] (sol/flatten [0 1 2])))

(t/deftest "flattens a nested array"
  (t/assert-equal [] (sol/flatten [[[]]])))

(t/deftest "flattens array with just integers present"
  (t/assert-equal [1 2 3 4 5 6 7 8] (sol/flatten [1 [2 3 4 5 6 7] 8])))

(t/deftest "5 level nesting"
  (t/assert-equal [0 2 2 3 8 100 4 50 -2] (sol/flatten [0 2 [[2 3] 8 100 4 [[[50]]]] -2])))

(t/deftest "6 level nesting"
  (t/assert-equal [1 2 3 4 5 6 7 8] (sol/flatten [1 [2 [[3]] [4 [[5]]] 6 7] 8])))

(t/deftest "null values are omitted from the final result"
  (t/assert-equal [1 2] (sol/flatten [1 2 nil])))

(t/deftest "consecutive null values at the front of the array are omitted from the final result"
  (t/assert-equal [3] (sol/flatten [nil nil 3])))

(t/deftest "consecutive null values in the middle of the array are omitted from the final result"
  (t/assert-equal [1 4] (sol/flatten [1 nil nil 4])))

(t/deftest "6 level nested array with null values"
  (t/assert-equal [0 2 2 3 8 100 -2] (sol/flatten [0 2 [[2 3] 8 [[100]] nil [[nil]]] -2])))

(t/deftest "all values in nested array are null"
  (t/assert-equal [] (sol/flatten [nil [[[nil]]] nil nil [[nil nil] nil] nil])))

(t/run)
