(import test :as t)
(import ../luhn :as sol)

(t/deftest "single digit strings can not be valid"
  (t/assert-false (sol/valid? "1")))

(t/deftest "a single zero is invalid"
  (t/assert-false (sol/valid? "0")))

(t/deftest "a simple valid SIN that remains valid if reversed"
  (t/assert-true (sol/valid? "059")))

(t/deftest "a simple valid SIN that becomes invalid if reversed"
  (t/assert-true (sol/valid? "59")))

(t/deftest "a valid Canadian SIN"
  (t/assert-true (sol/valid? "055 444 285")))

(t/deftest "invalid Canadian SIN"
  (t/assert-false (sol/valid? "055 444 286")))

(t/deftest "invalid credit card"
  (t/assert-false (sol/valid? "8273 1232 7352 0569")))

(t/deftest "invalid long number with an even remainder"
  (t/assert-false (sol/valid? "1 2345 6789 1234 5678 9012")))

(t/deftest "invalid long number with a remainder divisible by 5"
  (t/assert-false (sol/valid? "1 2345 6789 1234 5678 9013")))

(t/deftest "valid number with an even number of digits"
  (t/assert-true (sol/valid? "095 245 88")))

(t/deftest "valid number with an odd number of spaces"
  (t/assert-true (sol/valid? "234 567 891 234")))

(t/deftest "valid strings with a non-digit added at the end become invalid"
  (t/assert-false (sol/valid? "059a")))

(t/deftest "valid strings with punctuation included become invalid"
  (t/assert-false (sol/valid? "055-444-285")))

(t/deftest "valid strings with symbols included become invalid"
  (t/assert-false (sol/valid? "055# 444$ 285")))

(t/deftest "single zero with space is invalid"
  (t/assert-false (sol/valid? " 0")))

(t/deftest "more than a single zero is valid"
  (t/assert-true (sol/valid? "0000 0")))

(t/deftest "input digit 9 is correctly converted to output digit 9"
  (t/assert-true (sol/valid? "091")))

(t/deftest "very long input is valid"
  (t/assert-true (sol/valid? "9999999999 9999999999 9999999999 9999999999")))

(t/deftest "valid luhn with an odd number of digits and non zero first digit"
  (t/assert-true (sol/valid? "109")))

(t/deftest "using ascii value for non-doubled non-digit isn't allowed"
  (t/assert-false (sol/valid? "055b 444 285")))

(t/deftest "using ascii value for doubled non-digit isn't allowed"
  (t/assert-false (sol/valid? ":9")))

(t/deftest "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed"
  (t/assert-false (sol/valid? "59%59")))

(t/run)
