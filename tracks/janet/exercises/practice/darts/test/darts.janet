(import test :as t)
(import ../darts :as sol)

(t/deftest "Missed target"
  (t/assert-equal 0 (sol/score -9 9)))

(t/deftest "On the outer circle"
  (t/assert-equal 1 (sol/score 0 10)))

(t/deftest "On the middle circle"
  (t/assert-equal 5 (sol/score -5 0)))

(t/deftest "On the inner circle"
  (t/assert-equal 10 (sol/score 0 -1)))

(t/deftest "Exactly on center"
  (t/assert-equal 10 (sol/score 0 0)))

(t/deftest "Near the center"
  (t/assert-equal 10 (sol/score -0.1 -0.1)))

(t/deftest "Just within the inner circle"
  (t/assert-equal 10 (sol/score 0.7 0.7)))

(t/deftest "Just outside the inner circle"
  (t/assert-equal 5 (sol/score 0.8 -0.8)))

(t/deftest "Just within the middle circle"
  (t/assert-equal 5 (sol/score -3.5 3.5)))

(t/deftest "Just outside the middle circle"
  (t/assert-equal 1 (sol/score -3.6 -3.6)))

(t/deftest "Just within the outer circle"
  (t/assert-equal 1 (sol/score -7 7)))

(t/deftest "Just outside the outer circle"
  (t/assert-equal 0 (sol/score 7.1 -7.1)))

(t/deftest "Asymmetric position between the inner and middle circles"
  (t/assert-equal 5 (sol/score 0.5 -4)))

(t/run)
