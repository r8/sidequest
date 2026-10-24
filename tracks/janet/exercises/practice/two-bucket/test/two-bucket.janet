(import test :as t)
(import ../two-bucket :as sol)

(t/deftest "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one"
  (t/assert-equal {:moves 4 :goal-bucket :one :other-bucket 5}
    (sol/measure 3 5 1 :one)))

(t/deftest "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two"
  (t/assert-equal {:moves 8 :goal-bucket :two :other-bucket 3}
    (sol/measure 3 5 1 :two)))

(t/deftest "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one"
  (t/assert-equal {:moves 14 :goal-bucket :one :other-bucket 11}
    (sol/measure 7 11 2 :one)))

(t/deftest "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two"
  (t/assert-equal {:moves 18 :goal-bucket :two :other-bucket 7}
    (sol/measure 7 11 2 :two)))

(t/deftest "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two"
  (t/assert-equal {:moves 1 :goal-bucket :two :other-bucket 0}
    (sol/measure 1 3 3 :two)))

(t/deftest "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two"
  (t/assert-equal {:moves 2 :goal-bucket :two :other-bucket 2}
    (sol/measure 2 3 3 :one)))

(t/deftest "Measure using bucket one much bigger than bucket two"
  (t/assert-equal {:moves 6 :goal-bucket :one :other-bucket 1}
    (sol/measure 5 1 2 :one)))

(t/deftest "Measure using bucket one much smaller than bucket two"
  (t/assert-equal {:moves 6 :goal-bucket :two :other-bucket 0}
    (sol/measure 3 15 9 :one)))

(t/deftest "Not possible to reach the goal"
  (t/assert-error "impossible" (sol/measure 6 15 5 :one)))

(t/deftest "With the same buckets but a different goal, then it is possible"
  (t/assert-equal {:moves 10 :goal-bucket :two :other-bucket 0}
    (sol/measure 6 15 9 :one)))

(t/deftest "Goal larger than both buckets is impossible"
  (t/assert-error "impossible" (sol/measure 5 7 8 :one)))

(t/run)
