(import test :as t)
(import ../leap :as sol)

(t/deftest "year not divisible by 4 in common year"
  (t/assert-false (sol/leap-year? 2015)))

(t/deftest "year divisible by 2, not divisible by 4 in common year"
  (t/assert-false (sol/leap-year? 1970)))

(t/deftest "year divisible by 4, not divisible by 100 in leap year"
  (t/assert-true (sol/leap-year? 1996)))

(t/deftest "year divisible by 4 and 5 is still a leap year"
  (t/assert-true (sol/leap-year? 1960)))

(t/deftest "year divisible by 100, not divisible by 400 in common year"
  (t/assert-false (sol/leap-year? 2100)))

(t/deftest "year divisible by 100 but not by 3 is still not a leap year"
  (t/assert-false (sol/leap-year? 1900)))

(t/deftest "year divisible by 400 is leap year"
  (t/assert-true (sol/leap-year? 2000)))

(t/deftest "year divisible by 400 but not by 125 is still a leap year"
  (t/assert-true (sol/leap-year? 2400)))

(t/deftest "year divisible by 200, not divisible by 400 in common year"
  (t/assert-false (sol/leap-year? 1800)))

(t/run)
