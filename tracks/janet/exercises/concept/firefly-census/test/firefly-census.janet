(import test :as t)
(import ../firefly-census :as sol)

(t/deftest "1. the total of a short season"
  (t/assert-equal 50 (sol/total @[12 0 31 7])))

(t/deftest "1. the total of a single night"
  (t/assert-equal 9 (sol/total @[9])))

(t/deftest "1. the total of no nights"
  (t/assert-equal 0 (sol/total @[])))

(t/deftest "2. busy nights above a threshold"
  (t/assert-equal 2 (sol/busy-nights @[12 0 31 7] 10)))

(t/deftest "2. a count equal to the threshold is busy"
  (t/assert-equal 3 (sol/busy-nights @[10 9 10 11] 10)))

(t/deftest "2. no busy nights"
  (t/assert-equal 0 (sol/busy-nights @[1 2 3] 50)))

(t/deftest "3. the first quiet night"
  (t/assert-equal 2 (sol/first-quiet-night @[12 9 0 31 0])))

(t/deftest "3. a quiet first night"
  (t/assert-equal 0 (sol/first-quiet-night @[0 4])))

(t/deftest "3. no quiet night"
  (t/assert-equal nil (sol/first-quiet-night @[3 1 4 1 5])))

(t/deftest "4. correct the first night of a single week"
  (t/assert-equal @[10 3 3] (sol/correct-counts! @[20 3 3])))

(t/deftest "4. correct the first nights of two weeks"
  (t/assert-equal @[10 3 3 3 3 3 3 4 1] (sol/correct-counts! @[20 3 3 3 3 3 3 8 1])))

(t/deftest "4. correcting changes the counts themselves"
  (def counts @[6 1 1 1 1 1 1 2 1 1 1 1 1 1 4])
  (sol/correct-counts! counts)
  (t/assert-equal @[3 1 1 1 1 1 1 1 1 1 1 1 1 1 2] counts))

(t/deftest "4. nothing to correct in an empty season"
  (t/assert-equal @[] (sol/correct-counts! @[])))

(t/deftest "5. the goal is reached on the third night"
  (t/assert-equal 3 (sol/nights-to-reach @[12 0 31 7] 40)))

(t/deftest "5. the goal is reached exactly"
  (t/assert-equal 2 (sol/nights-to-reach @[12 8 31] 20)))

(t/deftest "5. the goal is reached on the first night"
  (t/assert-equal 1 (sol/nights-to-reach @[50 1] 20)))

(t/deftest "5. the goal is never reached"
  (t/assert-equal nil (sol/nights-to-reach @[1 2 3] 100)))

(t/deftest "5. a goal of zero needs no nights"
  (t/assert-equal 0 (sol/nights-to-reach @[5 5] 0)))

(t/run)
