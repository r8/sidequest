(import test :as t)
(import ../dominoes :as sol)

(t/deftest "empty input = empty output"
  (t/assert-true (sol/can-chain? [])))

(t/deftest "singleton input = singleton output"
  (t/assert-true (sol/can-chain? [[1 1]])))

(t/deftest "singleton that can't be chained"
  (t/assert-false (sol/can-chain? [[1 2]])))

(t/deftest "three elements"
  (t/assert-true (sol/can-chain? [[1 2] [3 1] [2 3]])))

(t/deftest "can reverse dominoes"
  (t/assert-true (sol/can-chain? [[1 2] [1 3] [2 3]])))

(t/deftest "can't be chained"
  (t/assert-false (sol/can-chain? [[1 2] [4 1] [2 3]])))

(t/deftest "disconnected - simple"
  (t/assert-false (sol/can-chain? [[1 1] [2 2]])))

(t/deftest "disconnected - double loop"
  (t/assert-false (sol/can-chain? [[1 2] [2 1] [3 4] [4 3]])))

(t/deftest "disconnected - single isolated"
  (t/assert-false (sol/can-chain? [[1 2] [2 3] [3 1] [4 4]])))

(t/deftest "need backtrack"
  (t/assert-true (sol/can-chain? [[1 2] [2 3] [3 1] [2 4] [2 4]])))

(t/deftest "separate loops"
  (t/assert-true (sol/can-chain? [[1 2] [2 3] [3 1] [1 1] [2 2] [3 3]])))

(t/deftest "nine elements"
  (t/assert-true (sol/can-chain? [[1 2] [5 3] [3 1] [1 2] [2 4] [1 6] [2 3] [3 4] [5 6]])))

(t/deftest "separate three-domino loops"
  (t/assert-false (sol/can-chain? [[1 2] [2 3] [3 1] [4 5] [5 6] [6 4]])))

(t/run)
