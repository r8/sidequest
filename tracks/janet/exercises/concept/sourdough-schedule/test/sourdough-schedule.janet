(import test :as t)
(import ../sourdough-schedule :as sol)

(t/deftest "1. the proofing time is 240 minutes"
  (t/assert-equal 240 (eval 'sol/proof-minutes)))

(t/deftest "1. the proofing time is four hours"
  (t/assert-equal 4 (/ (eval 'sol/proof-minutes) 60)))

(t/deftest "2. remaining proofing time after 90 minutes"
  (t/assert-equal 150 (sol/remaining-proof 90)))

(t/deftest "2. remaining proofing time at the start"
  (t/assert-equal 240 (sol/remaining-proof 0)))

(t/deftest "2. no proofing time remains at the end"
  (t/assert-equal 0 (sol/remaining-proof 240)))

(t/deftest "3. preparation time for one round"
  (t/assert-equal 15 (sol/prep-minutes 1)))

(t/deftest "3. preparation time for four rounds"
  (t/assert-equal 60 (sol/prep-minutes 4)))

(t/deftest "3. preparation time for no rounds"
  (t/assert-equal 0 (sol/prep-minutes 0)))

(t/deftest "4. total time for three rounds and 20 minutes of proofing"
  (t/assert-equal 65 (sol/total-minutes 3 20)))

(t/deftest "4. total time for one round, before proofing"
  (t/assert-equal 15 (sol/total-minutes 1 0)))

(t/deftest "4. total time for six rounds and a full proof"
  (t/assert-equal 330 (sol/total-minutes 6 240)))

(t/run)
