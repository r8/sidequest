(import test :as t)
(import ../collatz-conjecture :as sol)

(t/deftest "zero steps for one"
  (t/assert-equal 0 (sol/steps 1)))

(t/deftest "divide if even"
  (t/assert-equal 4 (sol/steps 16)))

(t/deftest "even and odd steps"
  (t/assert-equal 9 (sol/steps 12)))

(t/deftest "large number of even and odd steps"
  (t/assert-equal 152 (sol/steps 1000000)))

(t/deftest "zero is an error"
  (t/assert-error "Only positive integers are allowed" (sol/steps 0)))

(t/deftest "negative value is an error"
  (t/assert-error "Only positive integers are allowed" (sol/steps -15)))

(t/run)
