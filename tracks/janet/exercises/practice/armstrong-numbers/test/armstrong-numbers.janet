(import test :as t)
(import ../armstrong-numbers :as sol)

(t/deftest "Zero is an Armstrong number"
  (t/assert-true (sol/armstrong-number? 0)))

(t/deftest "Single-digit numbers are Armstrong numbers"
  (t/assert-true (sol/armstrong-number? 5)))

(t/deftest "There are no two-digit Armstrong numbers"
  (t/assert-false (sol/armstrong-number? 10)))

(t/deftest "Three-digit number that is an Armstrong number"
  (t/assert-true (sol/armstrong-number? 153)))

(t/deftest "Three-digit number that is not an Armstrong number"
  (t/assert-false (sol/armstrong-number? 100)))

(t/deftest "Four-digit number that is an Armstrong number"
  (t/assert-true (sol/armstrong-number? 9474)))

(t/deftest "Four-digit number that is not an Armstrong number"
  (t/assert-false (sol/armstrong-number? 9475)))

(t/deftest "Seven-digit number that is an Armstrong number"
  (t/assert-true (sol/armstrong-number? 9926315)))

(t/deftest "Seven-digit number that is not an Armstrong number"
  (t/assert-false (sol/armstrong-number? 9926314)))

(t/run)
