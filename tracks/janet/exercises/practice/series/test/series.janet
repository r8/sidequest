(import test :as t)
(import ../series :as sol)

(t/deftest "slices of one from one"
  (t/assert-equal ["1"] (sol/slices "1" 1)))

(t/deftest "slices of one from two"
  (t/assert-equal ["1" "2"] (sol/slices "12" 1)))

(t/deftest "slices of two"
  (t/assert-equal ["35"] (sol/slices "35" 2)))

(t/deftest "slices of two overlap"
  (t/assert-equal ["91" "14" "42"] (sol/slices "9142" 2)))

(t/deftest "slices can include duplicates"
  (t/assert-equal ["777" "777" "777" "777"] (sol/slices "777777" 3)))

(t/deftest "slices of a long series"
  (t/assert-equal ["91849" "18493" "84939" "49390" "93904" "39042" "90424" "04243"] (sol/slices "918493904243" 5)))

(t/deftest "slice length is too large"
  (t/assert-error "slice length cannot be greater than series length" (sol/slices "12345" 6)))

(t/deftest "slice length is way too large"
  (t/assert-error "slice length cannot be greater than series length" (sol/slices "12345" 42)))

(t/deftest "slice length cannot be zero"
  (t/assert-error "slice length cannot be zero" (sol/slices "12345" 0)))

(t/deftest "slice length cannot be negative"
  (t/assert-error "slice length cannot be negative" (sol/slices "123" -1)))

(t/deftest "empty series is invalid"
  (t/assert-error "series cannot be empty" (sol/slices "" 1)))

(t/run)
