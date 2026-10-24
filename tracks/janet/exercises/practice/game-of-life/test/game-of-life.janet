(import test :as t)
(import ../game-of-life :as sol)

(t/deftest "empty matrix"
  (t/assert-equal [] (sol/tick [])))

(t/deftest "live cells with zero live neighbors die"
  (t/assert-equal [[0 0 0] [0 0 0] [0 0 0]] (sol/tick [[0 0 0] [0 1 0] [0 0 0]])))

(t/deftest "live cells with only one live neighbor die"
  (t/assert-equal [[0 0 0] [0 0 0] [0 0 0]] (sol/tick [[0 0 0] [0 1 0] [0 1 0]])))

(t/deftest "live cells with two live neighbors stay alive"
  (t/assert-equal [[0 0 0] [1 0 1] [0 0 0]] (sol/tick [[1 0 1] [1 0 1] [1 0 1]])))

(t/deftest "live cells with three live neighbors stay alive"
  (t/assert-equal [[0 0 0] [1 0 0] [1 1 0]] (sol/tick [[0 1 0] [1 0 0] [1 1 0]])))

(t/deftest "dead cells with three live neighbors become alive"
  (t/assert-equal [[0 0 0] [1 1 0] [0 0 0]] (sol/tick [[1 1 0] [0 0 0] [1 0 0]])))

(t/deftest "live cells with four or more neighbors die"
  (t/assert-equal [[1 0 1] [0 0 0] [1 0 1]] (sol/tick [[1 1 1] [1 1 1] [1 1 1]])))

(t/deftest "bigger matrix"
  (t/assert-equal [[1 1 0 1 1 0 0 0] [0 0 0 0 0 1 1 0] [1 0 1 1 1 1 0 1] [1 0 0 0 0 0 0 1] [1 1 0 0 1 0 0 1] [1 1 0 1 0 0 0 1] [1 0 0 0 0 0 0 0] [0 0 0 0 0 0 1 1]] (sol/tick [[1 1 0 1 1 0 0 0] [1 0 1 1 0 0 0 0] [1 1 1 0 0 1 1 1] [0 0 0 0 0 1 1 0] [1 0 0 0 1 1 0 0] [1 1 0 0 0 1 1 1] [0 0 1 0 1 0 0 1] [1 0 0 0 0 0 1 1]])))

(t/run)
