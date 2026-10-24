(import test :as t)
(import ../nth-prime :as sol)

(t/deftest "first prime"
  (t/assert-equal 2 (sol/prime 1)))

(t/deftest "second prime"
  (t/assert-equal 3 (sol/prime 2)))

(t/deftest "sixth prime"
  (t/assert-equal 13 (sol/prime 6)))

(t/deftest "big prime"
  (t/assert-equal 104743 (sol/prime 10001)))

(t/deftest "there is no zeroth prime"
  (t/assert-error "there is no zeroth prime" (sol/prime 0)))

(t/run)
