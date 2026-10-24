(import test :as t)
(import ../grains :as sol)

(t/deftest "grains on square 1"
  (t/assert-equal (int/u64 1) (sol/square 1)))

(t/deftest "grains on square 2"
  (t/assert-equal (int/u64 2) (sol/square 2)))

(t/deftest "grains on square 3"
  (t/assert-equal (int/u64 4) (sol/square 3)))

(t/deftest "grains on square 4"
  (t/assert-equal (int/u64 8) (sol/square 4)))

(t/deftest "grains on square 16"
  (t/assert-equal (int/u64 32768) (sol/square 16)))

(t/deftest "grains on square 32"
  (t/assert-equal (int/u64 2147483648) (sol/square 32)))

(t/deftest "grains on square 64"
  (t/assert-equal (int/u64 "9223372036854775808") (sol/square 64)))

(t/deftest "square 0 is invalid"
  (t/assert-error "square must be between 1 and 64" (sol/square 0)))

(t/deftest "negative square is invalid"
  (t/assert-error "square must be between 1 and 64" (sol/square -1)))

(t/deftest "square greater than 64 is invalid"
  (t/assert-error "square must be between 1 and 64" (sol/square 65)))

(t/deftest "returns the total number of grains on the board"
  (t/assert-equal (int/u64 "18446744073709551615") (sol/total)))

(t/run)
