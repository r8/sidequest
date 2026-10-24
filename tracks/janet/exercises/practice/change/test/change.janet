(import test :as t)
(import ../change :as sol)

(t/deftest "change for 1 cent"
  (t/assert-equal [1] (sol/find-fewest-coins [1 5 10 25] 1)))

(t/deftest "single coin change"
  (t/assert-equal [25] (sol/find-fewest-coins [1 5 10 25 100] 25)))

(t/deftest "multiple coin change"
  (t/assert-equal [5 10] (sol/find-fewest-coins [1 5 10 25 100] 15)))

(t/deftest "change with Lilliputian Coins"
  (t/assert-equal [4 4 15] (sol/find-fewest-coins [1 4 15 20 50] 23)))

(t/deftest "change with Lower Elbonia Coins"
  (t/assert-equal [21 21 21] (sol/find-fewest-coins [1 5 10 21 25] 63)))

(t/deftest "large target values"
  (t/assert-equal [2 2 5 20 20 50 100 100 100 100 100 100 100 100 100] (sol/find-fewest-coins [1 2 5 10 20 50 100] 999)))

(t/deftest "possible change without unit coins available"
  (t/assert-equal [2 2 2 5 10] (sol/find-fewest-coins [2 5 10 20 50] 21)))

(t/deftest "another possible change without unit coins available"
  (t/assert-equal [4 4 4 5 5 5] (sol/find-fewest-coins [4 5] 27)))

(t/deftest "a greedy approach is not optimal"
  (t/assert-equal [10 10] (sol/find-fewest-coins [1 10 11] 20)))

(t/deftest "no coins make 0 change"
  (t/assert-equal [] (sol/find-fewest-coins [1 5 10 21 25] 0)))

(t/deftest "error testing for change smaller than the smallest of coins"
  (t/assert-error "can't make target with given coins" (sol/find-fewest-coins [5 10] 3)))

(t/deftest "error if no combination can add up to target"
  (t/assert-error "can't make target with given coins" (sol/find-fewest-coins [5 10] 94)))

(t/deftest "cannot find negative change values"
  (t/assert-error "target can't be negative" (sol/find-fewest-coins [1 2 5] -5)))

(t/run)
