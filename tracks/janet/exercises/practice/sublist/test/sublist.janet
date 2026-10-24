(import test :as t)
(import ../sublist :as sol)

(t/deftest "empty lists"
  (t/assert-equal :equal (sol/sublist [] [])))

(t/deftest "empty list within non empty list"
  (t/assert-equal :sublist (sol/sublist [] [1 2 3])))

(t/deftest "non empty list contains empty list"
  (t/assert-equal :superlist (sol/sublist [1 2 3] [])))

(t/deftest "list equals itself"
  (t/assert-equal :equal (sol/sublist [1 2 3] [1 2 3])))

(t/deftest "different lists"
  (t/assert-equal :unequal (sol/sublist [1 2 3] [2 3 4])))

(t/deftest "false start"
  (t/assert-equal :sublist (sol/sublist [1 2 5] [0 1 2 3 1 2 5 6])))

(t/deftest "consecutive"
  (t/assert-equal :sublist (sol/sublist [1 1 2] [0 1 1 1 2 1 2])))

(t/deftest "sublist at start"
  (t/assert-equal :sublist (sol/sublist [0 1 2] [0 1 2 3 4 5])))

(t/deftest "sublist in middle"
  (t/assert-equal :sublist (sol/sublist [2 3 4] [0 1 2 3 4 5])))

(t/deftest "sublist at end"
  (t/assert-equal :sublist (sol/sublist [3 4 5] [0 1 2 3 4 5])))

(t/deftest "at start of superlist"
  (t/assert-equal :superlist (sol/sublist [0 1 2 3 4 5] [0 1 2])))

(t/deftest "in middle of superlist"
  (t/assert-equal :superlist (sol/sublist [0 1 2 3 4 5] [2 3])))

(t/deftest "at end of superlist"
  (t/assert-equal :superlist (sol/sublist [0 1 2 3 4 5] [3 4 5])))

(t/deftest "first list missing element from second list"
  (t/assert-equal :unequal (sol/sublist [1 3] [1 2 3])))

(t/deftest "second list missing element from first list"
  (t/assert-equal :unequal (sol/sublist [1 2 3] [1 3])))

(t/deftest "first list missing additional digits from second list"
  (t/assert-equal :unequal (sol/sublist [1 2] [1 22])))

(t/deftest "order matters to a list"
  (t/assert-equal :unequal (sol/sublist [1 2 3] [3 2 1])))

(t/deftest "same digits but different numbers"
  (t/assert-equal :unequal (sol/sublist [1 0 1] [10 1])))

(t/run)
