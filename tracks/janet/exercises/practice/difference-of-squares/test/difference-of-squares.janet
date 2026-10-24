(import test :as t)
(import ../difference-of-squares :as sol)

(t/deftest "square of sum 1"
  (t/assert-equal 1 (sol/square-of-sum 1)))

(t/deftest "square of sum 5"
  (t/assert-equal 225 (sol/square-of-sum 5)))

(t/deftest "square of sum 100"
  (t/assert-equal 25502500 (sol/square-of-sum 100)))

(t/deftest "sum of squares 1"
  (t/assert-equal 1 (sol/sum-of-squares 1)))

(t/deftest "sum of squares 5"
  (t/assert-equal 55 (sol/sum-of-squares 5)))

(t/deftest "sum of squares 100"
  (t/assert-equal 338350 (sol/sum-of-squares 100)))

(t/deftest "difference of squares 1"
  (t/assert-equal 0 (sol/difference-of-squares 1)))

(t/deftest "difference of squares 5"
  (t/assert-equal 170 (sol/difference-of-squares 5)))

(t/deftest "difference of squares 100"
  (t/assert-equal 25164150 (sol/difference-of-squares 100)))

(t/run)
