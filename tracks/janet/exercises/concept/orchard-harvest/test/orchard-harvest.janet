(import test :as t)
(import ../orchard-harvest :as sol)

(t/deftest "1. full crates from 100 apples"
  (t/assert-equal 4 (sol/crates 100)))

(t/deftest "1. exactly one crate"
  (t/assert-equal 1 (sol/crates 24)))

(t/deftest "1. not enough apples for a crate"
  (t/assert-equal 0 (sol/crates 23)))

(t/deftest "2. loose apples from 100 apples"
  (t/assert-equal 4 (sol/leftover 100)))

(t/deftest "2. no loose apples when the crates are exactly full"
  (t/assert-equal 0 (sol/leftover 48)))

(t/deftest "2. all apples are loose when there are fewer than a crate"
  (t/assert-equal 23 (sol/leftover 23)))

(t/deftest "3. crates needed for 100 apples"
  (t/assert-equal 5 (sol/crates-needed 100)))

(t/deftest "3. crates needed when they are exactly full"
  (t/assert-equal 2 (sol/crates-needed 48)))

(t/deftest "3. one crate for a single apple"
  (t/assert-equal 1 (sol/crates-needed 1)))

(t/deftest "3. no crates for no apples"
  (t/assert-equal 0 (sol/crates-needed 0)))

(t/deftest "4. a fractional average weight"
  (t/assert-equal 112.5 (sol/average-weight 450 4)))

(t/deftest "4. a whole average weight"
  (t/assert-equal 125 (sol/average-weight 3000 24)))

(t/deftest "4. the average of a single apple is its weight"
  (t/assert-equal 180 (sol/average-weight 180 1)))

(t/deftest "5. rounding down to the cent"
  (t/assert-equal 1.23 (sol/round-to-cents 1.234)))

(t/deftest "5. rounding up to the cent"
  (t/assert-equal 4 (sol/round-to-cents 3.999)))

(t/deftest "5. a half cent rounds up"
  (t/assert-equal 0.13 (sol/round-to-cents 0.125)))

(t/deftest "5. an amount already in cents stays the same"
  (t/assert-equal 2.5 (sol/round-to-cents 2.5)))

(t/run)
