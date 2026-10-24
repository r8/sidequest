(import test :as t)
(import ../spiral-matrix :as sol)

(t/deftest "empty spiral"
  (t/assert-equal [] (sol/spiral-matrix 0)))

(t/deftest "trivial spiral"
  (t/assert-equal [[1]] (sol/spiral-matrix 1)))

(t/deftest "spiral of size 2"
  (t/assert-equal [[1 2] [4 3]] (sol/spiral-matrix 2)))

(t/deftest "spiral of size 3"
  (t/assert-equal [[1 2 3] [8 9 4] [7 6 5]] (sol/spiral-matrix 3)))

(t/deftest "spiral of size 4"
  (t/assert-equal [[1 2 3 4] [12 13 14 5] [11 16 15 6] [10 9 8 7]] (sol/spiral-matrix 4)))

(t/deftest "spiral of size 5"
  (t/assert-equal [[1 2 3 4 5] [16 17 18 19 6] [15 24 25 20 7] [14 23 22 21 8] [13 12 11 10 9]] (sol/spiral-matrix 5)))

(t/run)
