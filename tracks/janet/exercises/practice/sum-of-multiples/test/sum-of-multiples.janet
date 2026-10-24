(import test :as t)
(import ../sum-of-multiples :as sol)

(t/deftest "no multiples within limit"
  (t/assert-equal 0 (sol/sum-of-multiples [3 5] 1)))

(t/deftest "one factor has multiples within limit"
  (t/assert-equal 3 (sol/sum-of-multiples [3 5] 4)))

(t/deftest "more than one multiple within limit"
  (t/assert-equal 9 (sol/sum-of-multiples [3] 7)))

(t/deftest "more than one factor with multiples within limit"
  (t/assert-equal 23 (sol/sum-of-multiples [3 5] 10)))

(t/deftest "each multiple is only counted once"
  (t/assert-equal 2318 (sol/sum-of-multiples [3 5] 100)))

(t/deftest "a much larger limit"
  (t/assert-equal 233168 (sol/sum-of-multiples [3 5] 1000)))

(t/deftest "three factors"
  (t/assert-equal 51 (sol/sum-of-multiples [7 13 17] 20)))

(t/deftest "factors not relatively prime"
  (t/assert-equal 30 (sol/sum-of-multiples [4 6] 15)))

(t/deftest "some pairs of factors relatively prime and some not"
  (t/assert-equal 4419 (sol/sum-of-multiples [5 6 8] 150)))

(t/deftest "one factor is a multiple of another"
  (t/assert-equal 275 (sol/sum-of-multiples [5 25] 51)))

(t/deftest "much larger factors"
  (t/assert-equal 2203160 (sol/sum-of-multiples [43 47] 10000)))

(t/deftest "all numbers are multiples of 1"
  (t/assert-equal 4950 (sol/sum-of-multiples [1] 100)))

(t/deftest "no factors means an empty sum"
  (t/assert-equal 0 (sol/sum-of-multiples [] 10000)))

(t/deftest "the only multiple of 0 is 0"
  (t/assert-equal 0 (sol/sum-of-multiples [0] 1)))

(t/deftest "the factor 0 does not affect the sum of multiples of other factors"
  (t/assert-equal 3 (sol/sum-of-multiples [3 0] 4)))

(t/deftest "solutions using include-exclude must extend to cardinality greater than 3"
  (t/assert-equal 39614537 (sol/sum-of-multiples [2 3 5 7 11] 10000)))

(t/run)
