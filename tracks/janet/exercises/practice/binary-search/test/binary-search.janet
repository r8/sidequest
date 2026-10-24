(import test :as t)
(import ../binary-search :as sol)

(t/deftest "finds a value in an array with one element"
  (t/assert-equal 0 (sol/find [6] 6)))

(t/deftest "finds a value in the middle of an array"
  (t/assert-equal 3 (sol/find [1 3 4 6 8 9 11] 6)))

(t/deftest "finds a value at the beginning of an array"
  (t/assert-equal 0 (sol/find [1 3 4 6 8 9 11] 1)))

(t/deftest "finds a value at the end of an array"
  (t/assert-equal 6 (sol/find [1 3 4 6 8 9 11] 11)))

(t/deftest "finds a value in an array of odd length"
  (t/assert-equal 9 (sol/find [1 3 5 8 13 21 34 55 89 144 233 377 634] 144)))

(t/deftest "finds a value in an array of even length"
  (t/assert-equal 5 (sol/find [1 3 5 8 13 21 34 55 89 144 233 377] 21)))

(t/deftest "identifies that a value is not included in the array"
  (t/assert-error "value not in array" (sol/find [1 3 4 6 8 9 11] 7)))

(t/deftest "a value smaller than the array's smallest value is not found"
  (t/assert-error "value not in array" (sol/find [1 3 4 6 8 9 11] 0)))

(t/deftest "a value larger than the array's largest value is not found"
  (t/assert-error "value not in array" (sol/find [1 3 4 6 8 9 11] 13)))

(t/deftest "nothing is found in an empty array"
  (t/assert-error "value not in array" (sol/find [] 1)))

(t/deftest "nothing is found when the left and right bounds cross"
  (t/assert-error "value not in array" (sol/find [1 2] 0)))

(t/run)
