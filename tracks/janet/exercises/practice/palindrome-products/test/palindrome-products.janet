(import test :as t)
(import ../palindrome-products :as sol)

# The order of the factor pairs, and of the two numbers within a pair, is not significant.
(defn- normalize [result]
  (when result
    {:value (result :value)
     :factors (sorted (map |(tuple ;(sorted $)) (result :factors)))}))

(t/deftest "find the smallest palindrome from single digit factors"
  (t/assert-equal {:value 1 :factors [[1 1]]} (normalize (sol/smallest 1 9))))

(t/deftest "find the largest palindrome from single digit factors"
  (t/assert-equal {:value 9 :factors [[1 9] [3 3]]} (normalize (sol/largest 1 9))))

(t/deftest "find the smallest palindrome from double digit factors"
  (t/assert-equal {:value 121 :factors [[11 11]]} (normalize (sol/smallest 10 99))))

(t/deftest "find the largest palindrome from double digit factors"
  (t/assert-equal {:value 9009 :factors [[91 99]]} (normalize (sol/largest 10 99))))

(t/deftest "find the smallest palindrome from triple digit factors"
  (t/assert-equal {:value 10201 :factors [[101 101]]} (normalize (sol/smallest 100 999))))

(t/deftest "find the largest palindrome from triple digit factors"
  (t/assert-equal {:value 906609 :factors [[913 993]]} (normalize (sol/largest 100 999))))

(t/deftest "find the smallest palindrome from four digit factors"
  (t/assert-equal {:value 1002001 :factors [[1001 1001]]} (normalize (sol/smallest 1000 9999))))

(t/deftest "find the largest palindrome from four digit factors"
  (t/assert-equal {:value 99000099 :factors [[9901 9999]]} (normalize (sol/largest 1000 9999))))

(t/deftest "empty result for smallest if no palindrome in the range"
  (t/assert-equal nil (sol/smallest 1002 1003)))

(t/deftest "empty result for largest if no palindrome in the range"
  (t/assert-equal nil (sol/largest 15 15)))

(t/deftest "error result for smallest if min is more than max"
  (t/assert-error "min must be <= max" (sol/smallest 10000 1)))

(t/deftest "error result for largest if min is more than max"
  (t/assert-error "min must be <= max" (sol/largest 2 1)))

(t/deftest "smallest product does not use the smallest factor"
  (t/assert-equal {:value 10988901 :factors [[3297 3333]]} (normalize (sol/smallest 3215 4000))))

# Not in the canonical data: when the range starts at 0, the smallest palindrome is 0, and every
# number in the range is a factor of it with 0.
(t/deftest "smallest palindrome of a range starting at zero"
  (t/assert-equal {:value 0 :factors [[0 0] [0 1] [0 2] [0 3]]} (normalize (sol/smallest 0 3))))

(t/run)
