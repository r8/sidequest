(import test :as t)
(import ../all-your-base :as sol)

(t/deftest "single bit one to decimal"
  (t/assert-equal [1] (sol/rebase 2 [1] 10)))

(t/deftest "binary to single decimal"
  (t/assert-equal [5] (sol/rebase 2 [1 0 1] 10)))

(t/deftest "single decimal to binary"
  (t/assert-equal [1 0 1] (sol/rebase 10 [5] 2)))

(t/deftest "binary to multiple decimal"
  (t/assert-equal [4 2] (sol/rebase 2 [1 0 1 0 1 0] 10)))

(t/deftest "decimal to binary"
  (t/assert-equal [1 0 1 0 1 0] (sol/rebase 10 [4 2] 2)))

(t/deftest "trinary to hexadecimal"
  (t/assert-equal [2 10] (sol/rebase 3 [1 1 2 0] 16)))

(t/deftest "hexadecimal to trinary"
  (t/assert-equal [1 1 2 0] (sol/rebase 16 [2 10] 3)))

(t/deftest "15-bit integer"
  (t/assert-equal [6 10 45] (sol/rebase 97 [3 46 60] 73)))

(t/deftest "empty list"
  (t/assert-equal [0] (sol/rebase 2 [] 10)))

(t/deftest "single zero"
  (t/assert-equal [0] (sol/rebase 10 [0] 2)))

(t/deftest "multiple zeros"
  (t/assert-equal [0] (sol/rebase 10 [0 0 0] 2)))

(t/deftest "leading zeros"
  (t/assert-equal [4 2] (sol/rebase 7 [0 6 0] 10)))

(t/deftest "input base is one"
  (t/assert-error "input base must be >= 2" (sol/rebase 1 [0] 10)))

(t/deftest "input base is zero"
  (t/assert-error "input base must be >= 2" (sol/rebase 0 [] 10)))

(t/deftest "input base is negative"
  (t/assert-error "input base must be >= 2" (sol/rebase -2 [1] 10)))

(t/deftest "negative digit"
  (t/assert-error "all digits must satisfy 0 <= d < input base" (sol/rebase 2 [1 -1 1 0 1 0] 10)))

(t/deftest "invalid positive digit"
  (t/assert-error "all digits must satisfy 0 <= d < input base" (sol/rebase 2 [1 2 1 0 1 0] 10)))

(t/deftest "output base is one"
  (t/assert-error "output base must be >= 2" (sol/rebase 2 [1 0 1 0 1 0] 1)))

(t/deftest "output base is zero"
  (t/assert-error "output base must be >= 2" (sol/rebase 10 [7] 0)))

(t/deftest "output base is negative"
  (t/assert-error "output base must be >= 2" (sol/rebase 2 [1] -7)))

(t/deftest "both bases are negative"
  (t/assert-error "input base must be >= 2" (sol/rebase -2 [1] -7)))

(t/run)
