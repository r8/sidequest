(import test :as t)
(import ../eliuds-eggs :as sol)

(t/deftest "0 eggs"
  (t/assert-equal 0 (sol/egg-count 0)))

(t/deftest "1 egg"
  (t/assert-equal 1 (sol/egg-count 16)))

(t/deftest "4 eggs"
  (t/assert-equal 4 (sol/egg-count 89)))

(t/deftest "13 eggs"
  (t/assert-equal 13 (sol/egg-count 2000000000)))

(t/run)
