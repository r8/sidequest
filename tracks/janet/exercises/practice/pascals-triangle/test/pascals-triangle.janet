(import test :as t)
(import ../pascals-triangle :as sol)

(t/deftest "zero rows"
  (t/assert-equal [] (sol/rows 0)))

(t/deftest "single row"
  (t/assert-equal [[1]] (sol/rows 1)))

(t/deftest "two rows"
  (t/assert-equal [[1] [1 1]] (sol/rows 2)))

(t/deftest "three rows"
  (t/assert-equal [[1] [1 1] [1 2 1]] (sol/rows 3)))

(t/deftest "four rows"
  (t/assert-equal [[1] [1 1] [1 2 1] [1 3 3 1]] (sol/rows 4)))

(t/deftest "five rows"
  (t/assert-equal [[1] [1 1] [1 2 1] [1 3 3 1] [1 4 6 4 1]] (sol/rows 5)))

(t/deftest "six rows"
  (t/assert-equal [[1] [1 1] [1 2 1] [1 3 3 1] [1 4 6 4 1] [1 5 10 10 5 1]] (sol/rows 6)))

(t/deftest "ten rows"
  (t/assert-equal [[1] [1 1] [1 2 1] [1 3 3 1] [1 4 6 4 1] [1 5 10 10 5 1] [1 6 15 20 15 6 1] [1 7 21 35 35 21 7 1] [1 8 28 56 70 56 28 8 1] [1 9 36 84 126 126 84 36 9 1]] (sol/rows 10)))

(t/run)
