(import test :as t)
(import ../killer-sudoku-helper :as sol)

(t/deftest "1"
  (t/assert-equal [[1]] (sol/combinations {:sum 1 :size 1 :exclude []})))

(t/deftest "2"
  (t/assert-equal [[2]] (sol/combinations {:sum 2 :size 1 :exclude []})))

(t/deftest "3"
  (t/assert-equal [[3]] (sol/combinations {:sum 3 :size 1 :exclude []})))

(t/deftest "4"
  (t/assert-equal [[4]] (sol/combinations {:sum 4 :size 1 :exclude []})))

(t/deftest "5"
  (t/assert-equal [[5]] (sol/combinations {:sum 5 :size 1 :exclude []})))

(t/deftest "6"
  (t/assert-equal [[6]] (sol/combinations {:sum 6 :size 1 :exclude []})))

(t/deftest "7"
  (t/assert-equal [[7]] (sol/combinations {:sum 7 :size 1 :exclude []})))

(t/deftest "8"
  (t/assert-equal [[8]] (sol/combinations {:sum 8 :size 1 :exclude []})))

(t/deftest "9"
  (t/assert-equal [[9]] (sol/combinations {:sum 9 :size 1 :exclude []})))

(t/deftest "Cage with sum 45 contains all digits 1:9"
  (t/assert-equal [[1 2 3 4 5 6 7 8 9]] (sol/combinations {:sum 45 :size 9 :exclude []})))

(t/deftest "Cage with only 1 possible combination"
  (t/assert-equal [[1 2 4]] (sol/combinations {:sum 7 :size 3 :exclude []})))

(t/deftest "Cage with several combinations"
  (t/assert-equal [[1 9] [2 8] [3 7] [4 6]] (sol/combinations {:sum 10 :size 2 :exclude []})))

(t/deftest "Cage with several combinations that is restricted"
  (t/assert-equal [[2 8] [3 7]] (sol/combinations {:sum 10 :size 2 :exclude [1 4]})))

(t/run)
