(import test :as t)
(import ../night-market :as sol)

(t/deftest "1. open in the evening"
  (t/assert-equal true (sol/open? 20)))

(t/deftest "1. open from 18:00"
  (t/assert-equal true (sol/open? 18)))

(t/deftest "1. open after midnight"
  (t/assert-equal true (sol/open? 1)))

(t/deftest "1. closed from 2:00"
  (t/assert-equal false (sol/open? 2)))

(t/deftest "1. closed at noon"
  (t/assert-equal false (sol/open? 12)))

(t/deftest "2. an adult may enter alone"
  (t/assert-equal true (sol/can-enter? 30 false)))

(t/deftest "2. sixteen is old enough"
  (t/assert-equal true (sol/can-enter? 16 false)))

(t/deftest "2. a child may enter with an adult"
  (t/assert-equal true (sol/can-enter? 12 true)))

(t/deftest "2. a child may not enter alone"
  (t/assert-equal false (sol/can-enter? 12 false)))

(t/deftest "3. a small stall"
  (t/assert-equal 10 (sol/stall-fee "small")))

(t/deftest "3. a medium stall"
  (t/assert-equal 15 (sol/stall-fee "medium")))

(t/deftest "3. a large stall"
  (t/assert-equal 25 (sol/stall-fee "large")))

(t/deftest "3. an unknown size is free"
  (t/assert-equal 0 (sol/stall-fee "enormous")))

(t/deftest "4. a quiet market is green"
  (t/assert-equal "green" (sol/lantern-color 10)))

(t/deftest "4. fifty visitors is amber"
  (t/assert-equal "amber" (sol/lantern-color 50)))

(t/deftest "4. a busy market is amber"
  (t/assert-equal "amber" (sol/lantern-color 199)))

(t/deftest "4. a full market is red"
  (t/assert-equal "red" (sol/lantern-color 200)))

(t/deftest "5. last orders at one"
  (t/assert-equal "Last orders!" (sol/closing-call 1)))

(t/deftest "5. no announcement in the evening"
  (t/assert-equal nil (sol/closing-call 22)))

(t/deftest "5. no announcement at midnight"
  (t/assert-equal nil (sol/closing-call 0)))

(t/run)
