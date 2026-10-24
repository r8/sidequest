(import test :as t)
(import ../nesting-dolls :as sol)

(t/deftest "1. a set of three"
  (t/assert-equal 3 (sol/count-dolls [90 [60 [30 nil]]])))

(t/deftest "1. a single solid doll"
  (t/assert-equal 1 (sol/count-dolls [12 nil])))

(t/deftest "1. a set of six"
  (t/assert-equal 6 (sol/count-dolls [120 [100 [80 [60 [40 [20 nil]]]]]])))

(t/deftest "2. the smallest of a set of three"
  (t/assert-equal 30 (sol/smallest [90 [60 [30 nil]]])))

(t/deftest "2. a single solid doll is the smallest"
  (t/assert-equal 12 (sol/smallest [12 nil])))

(t/deftest "2. the smallest of a set of six"
  (t/assert-equal 20 (sol/smallest [120 [100 [80 [60 [40 [20 nil]]]]]])))

(t/deftest "3. the sizes of a set of three"
  (t/assert-equal [90 60 30] (sol/sizes [90 [60 [30 nil]]])))

(t/deftest "3. the size of a single solid doll"
  (t/assert-equal [12] (sol/sizes [12 nil])))

(t/deftest "3. the sizes of a set of five"
  (t/assert-equal [100 80 60 40 20] (sol/sizes [100 [80 [60 [40 [20 nil]]]]])))

(t/deftest "4. assemble a set of three"
  (t/assert-equal [90 [60 [30 nil]]] (sol/nest [90 60 30])))

(t/deftest "4. assemble a single doll"
  (t/assert-equal [12 nil] (sol/nest [12])))

(t/deftest "4. no sizes, no set"
  (t/assert-equal nil (sol/nest [])))

(t/deftest "4. assembling and listing the sizes again"
  (t/assert-equal [100 80 60 40 20] (sol/sizes (sol/nest [100 80 60 40 20]))))

(t/deftest "5. a set that closes"
  (t/assert-equal true (sol/closes? [90 [60 [30 nil]]])))

(t/deftest "5. a single solid doll closes"
  (t/assert-equal true (sol/closes? [12 nil])))

(t/deftest "5. a doll too big for the one around it"
  (t/assert-equal false (sol/closes? [90 [95 [30 nil]]])))

(t/deftest "5. two dolls of the same size do not close"
  (t/assert-equal false (sol/closes? [90 [60 [60 nil]]])))

(t/deftest "5. a problem deep inside the set"
  (t/assert-equal false (sol/closes? [120 [100 [80 [60 [70 [20 nil]]]]]])))

(t/run)
