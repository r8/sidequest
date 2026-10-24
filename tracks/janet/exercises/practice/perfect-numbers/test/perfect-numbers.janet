(import test :as t)
(import ../perfect-numbers :as sol)

(t/deftest "Smallest perfect number is classified correctly"
  (t/assert-equal :perfect (sol/classify 6)))

(t/deftest "Medium perfect number is classified correctly"
  (t/assert-equal :perfect (sol/classify 28)))

(t/deftest "Large perfect number is classified correctly"
  (t/assert-equal :perfect (sol/classify 33550336)))

(t/deftest "Smallest abundant number is classified correctly"
  (t/assert-equal :abundant (sol/classify 12)))

(t/deftest "Medium abundant number is classified correctly"
  (t/assert-equal :abundant (sol/classify 30)))

(t/deftest "Large abundant number is classified correctly"
  (t/assert-equal :abundant (sol/classify 33550335)))

(t/deftest "Perfect square abundant number is classified correctly"
  (t/assert-equal :abundant (sol/classify 196)))

(t/deftest "Smallest prime deficient number is classified correctly"
  (t/assert-equal :deficient (sol/classify 2)))

(t/deftest "Smallest non-prime deficient number is classified correctly"
  (t/assert-equal :deficient (sol/classify 4)))

(t/deftest "Medium deficient number is classified correctly"
  (t/assert-equal :deficient (sol/classify 32)))

(t/deftest "Large deficient number is classified correctly"
  (t/assert-equal :deficient (sol/classify 33550337)))

(t/deftest "Edge case (no factors other than itself) is classified correctly"
  (t/assert-equal :deficient (sol/classify 1)))

(t/deftest "Zero is rejected (as it is not a positive integer)"
  (t/assert-error "Classification is only possible for positive integers." (sol/classify 0)))

(t/deftest "Negative integer is rejected (as it is not a positive integer)"
  (t/assert-error "Classification is only possible for positive integers." (sol/classify -1)))

(t/run)
