(import test :as t)
(import ../list-ops :as sol)

(t/deftest "empty lists"
  (t/assert-equal [] (sol/append [] [])))

(t/deftest "list to empty list"
  (t/assert-equal [1 2 3 4] (sol/append [] [1 2 3 4])))

(t/deftest "empty list to list"
  (t/assert-equal [1 2 3 4] (sol/append [1 2 3 4] [])))

(t/deftest "non-empty lists"
  (t/assert-equal [1 2 2 3 4 5] (sol/append [1 2] [2 3 4 5])))

(t/deftest "empty list"
  (t/assert-equal [] (sol/concat [])))

(t/deftest "list of lists"
  (t/assert-equal [1 2 3 4 5 6] (sol/concat [[1 2] [3] [] [4 5 6]])))

(t/deftest "list of nested lists"
  (t/assert-equal [[1] [2] [3] [] [4 5 6]] (sol/concat [[[1] [2]] [[3]] [[]] [[4 5 6]]])))

(t/deftest "filter list returning only values that satisfy the filter function > empty list"
  (t/assert-equal [] (sol/filter (fn [x] (= 1 (mod x 2))) [])))

(t/deftest "non-empty list"
  (t/assert-equal [1 3 5] (sol/filter (fn [x] (= 1 (mod x 2))) [1 2 3 5])))

(t/deftest "returns the length of a list > empty list"
  (t/assert-equal 0 (sol/length [])))

(t/deftest "returns the length of a list > non-empty list"
  (t/assert-equal 4 (sol/length [1 2 3 4])))

(t/deftest "return a list of elements whose values equal the list value transformed by the mapping function > empty list"
  (t/assert-equal [] (sol/map (fn [x] (+ x 1)) [])))

(t/deftest "return a list of elements whose values equal the list value transformed by the mapping function > non-empty list"
  (t/assert-equal [2 4 6 8] (sol/map (fn [x] (+ x 1)) [1 3 5 7])))

(t/deftest "folds (reduces) the given list from the left with a function > empty list"
  (t/assert-equal 2 (sol/foldl (fn [acc el] (* el acc)) 2 [])))

(t/deftest "direction independent function applied to non-empty list"
  (t/assert-equal 15 (sol/foldl (fn [acc el] (+ el acc)) 5 [1 2 3 4])))

(t/deftest "direction dependent function applied to non-empty list"
  (t/assert-equal 64 (sol/foldl (fn [acc el] (/ el acc)) 24 [1 2 3 4])))

(t/deftest "folds (reduces) the given list from the right with a function > empty list"
  (t/assert-equal 2 (sol/foldr (fn [acc el] (* el acc)) 2 [])))

(t/deftest "folds (reduces) the given list from the right with a function > direction independent function applied to non-empty list"
  (t/assert-equal 15 (sol/foldr (fn [acc el] (+ el acc)) 5 [1 2 3 4])))

(t/deftest "folds (reduces) the given list from the right with a function > direction dependent function applied to non-empty list"
  (t/assert-equal 9 (sol/foldr (fn [acc el] (/ el acc)) 24 [1 2 3 4])))

(t/deftest "reverse the elements of the list > empty list"
  (t/assert-equal [] (sol/reverse [])))

(t/deftest "non-empty even-length list"
  (t/assert-equal [7 5 3 1] (sol/reverse [1 3 5 7])))

(t/deftest "non-empty odd-length list"
  (t/assert-equal [13 11 9 7 5 3 1] (sol/reverse [1 3 5 7 9 11 13])))

(t/deftest "list of lists is not flattened"
  (t/assert-equal [[4 5 6] [] [3] [1 2]] (sol/reverse [[1 2] [3] [] [4 5 6]])))

(t/run)
