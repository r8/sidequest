(import test :as t)
(import ../book-store :as sol)

(t/deftest "Only a single book"
  (t/assert-equal 800 (sol/total [1])))

(t/deftest "Two of the same book"
  (t/assert-equal 1600 (sol/total [2 2])))

(t/deftest "Empty basket"
  (t/assert-equal 0 (sol/total [])))

(t/deftest "Two different books"
  (t/assert-equal 1520 (sol/total [1 2])))

(t/deftest "Three different books"
  (t/assert-equal 2160 (sol/total [1 2 3])))

(t/deftest "Four different books"
  (t/assert-equal 2560 (sol/total [1 2 3 4])))

(t/deftest "Five different books"
  (t/assert-equal 3000 (sol/total [1 2 3 4 5])))

(t/deftest "Two groups of four is cheaper than group of five plus group of three"
  (t/assert-equal 5120 (sol/total [1 1 2 2 3 3 4 5])))

(t/deftest "Two groups of four is cheaper than groups of five and three"
  (t/assert-equal 5120 (sol/total [1 1 2 3 4 4 5 5])))

(t/deftest "Group of four plus group of two is cheaper than two groups of three"
  (t/assert-equal 4080 (sol/total [1 1 2 2 3 4])))

(t/deftest "Two each of first four books and one copy each of rest"
  (t/assert-equal 5560 (sol/total [1 1 2 2 3 3 4 4 5])))

(t/deftest "Two copies of each book"
  (t/assert-equal 6000 (sol/total [1 1 2 2 3 3 4 4 5 5])))

(t/deftest "Three copies of first book and two each of remaining"
  (t/assert-equal 6800 (sol/total [1 1 2 2 3 3 4 4 5 5 1])))

(t/deftest "Three each of first two books and two each of remaining books"
  (t/assert-equal 7520 (sol/total [1 1 2 2 3 3 4 4 5 5 1 2])))

(t/deftest "Four groups of four are cheaper than two groups each of five and three"
  (t/assert-equal 10240 (sol/total [1 1 2 2 3 3 4 5 1 1 2 2 3 3 4 5])))

(t/deftest "Check that groups of four are created properly even when there are more groups of three than groups of five"
  (t/assert-equal 14560 (sol/total [1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 5 5])))

(t/deftest "One group of one and four is cheaper than one group of two and three"
  (t/assert-equal 3360 (sol/total [1 1 2 3 4])))

(t/deftest "One group of one and two plus three groups of four is cheaper than one group of each size"
  (t/assert-equal 10000 (sol/total [1 2 2 3 3 3 4 4 4 4 5 5 5 5 5])))

(t/run)
