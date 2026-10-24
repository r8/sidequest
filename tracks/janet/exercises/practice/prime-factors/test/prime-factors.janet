(import test :as t)
(import ../prime-factors :as sol)

(t/deftest "no factors"
  (t/assert-equal [] (sol/factors 1)))

(t/deftest "prime number"
  (t/assert-equal [2] (sol/factors 2)))

(t/deftest "another prime number"
  (t/assert-equal [3] (sol/factors 3)))

(t/deftest "square of a prime"
  (t/assert-equal [3 3] (sol/factors 9)))

(t/deftest "product of first prime"
  (t/assert-equal [2 2] (sol/factors 4)))

(t/deftest "cube of a prime"
  (t/assert-equal [2 2 2] (sol/factors 8)))

(t/deftest "product of second prime"
  (t/assert-equal [3 3 3] (sol/factors 27)))

(t/deftest "product of third prime"
  (t/assert-equal [5 5 5 5] (sol/factors 625)))

(t/deftest "product of first and second prime"
  (t/assert-equal [2 3] (sol/factors 6)))

(t/deftest "product of primes and non-primes"
  (t/assert-equal [2 2 3] (sol/factors 12)))

(t/deftest "product of primes"
  (t/assert-equal [5 17 23 461] (sol/factors 901255)))

(t/deftest "factors include a large prime"
  (t/assert-equal [11 9539 894119] (sol/factors 93819012551)))

(t/run)
