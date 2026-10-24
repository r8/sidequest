(import test :as t)
(import ../robot-simulator :as sol)

(t/deftest "at origin facing north"
  (t/assert-equal {:position {:x 0 :y 0} :direction :north} (sol/make-robot {:x 0 :y 0} :north)))

(t/deftest "at negative position facing south"
  (t/assert-equal {:position {:x -1 :y -1} :direction :south} (sol/make-robot {:x -1 :y -1} :south)))

(t/deftest "changes north to east"
  (def robot (sol/make-robot {:x 0 :y 0} :north))
  (sol/move robot "R")
  (t/assert-equal {:position {:x 0 :y 0} :direction :east} robot))

(t/deftest "changes east to south"
  (def robot (sol/make-robot {:x 0 :y 0} :east))
  (sol/move robot "R")
  (t/assert-equal {:position {:x 0 :y 0} :direction :south} robot))

(t/deftest "changes south to west"
  (def robot (sol/make-robot {:x 0 :y 0} :south))
  (sol/move robot "R")
  (t/assert-equal {:position {:x 0 :y 0} :direction :west} robot))

(t/deftest "changes west to north"
  (def robot (sol/make-robot {:x 0 :y 0} :west))
  (sol/move robot "R")
  (t/assert-equal {:position {:x 0 :y 0} :direction :north} robot))

(t/deftest "changes north to west"
  (def robot (sol/make-robot {:x 0 :y 0} :north))
  (sol/move robot "L")
  (t/assert-equal {:position {:x 0 :y 0} :direction :west} robot))

(t/deftest "changes west to south"
  (def robot (sol/make-robot {:x 0 :y 0} :west))
  (sol/move robot "L")
  (t/assert-equal {:position {:x 0 :y 0} :direction :south} robot))

(t/deftest "changes south to east"
  (def robot (sol/make-robot {:x 0 :y 0} :south))
  (sol/move robot "L")
  (t/assert-equal {:position {:x 0 :y 0} :direction :east} robot))

(t/deftest "changes east to north"
  (def robot (sol/make-robot {:x 0 :y 0} :east))
  (sol/move robot "L")
  (t/assert-equal {:position {:x 0 :y 0} :direction :north} robot))

(t/deftest "facing north increments Y"
  (def robot (sol/make-robot {:x 0 :y 0} :north))
  (sol/move robot "A")
  (t/assert-equal {:position {:x 0 :y 1} :direction :north} robot))

(t/deftest "facing south decrements Y"
  (def robot (sol/make-robot {:x 0 :y 0} :south))
  (sol/move robot "A")
  (t/assert-equal {:position {:x 0 :y -1} :direction :south} robot))

(t/deftest "facing east increments X"
  (def robot (sol/make-robot {:x 0 :y 0} :east))
  (sol/move robot "A")
  (t/assert-equal {:position {:x 1 :y 0} :direction :east} robot))

(t/deftest "facing west decrements X"
  (def robot (sol/make-robot {:x 0 :y 0} :west))
  (sol/move robot "A")
  (t/assert-equal {:position {:x -1 :y 0} :direction :west} robot))

(t/deftest "moving east and north from README"
  (def robot (sol/make-robot {:x 7 :y 3} :north))
  (sol/move robot "RAALAL")
  (t/assert-equal {:position {:x 9 :y 4} :direction :west} robot))

(t/deftest "moving west and north"
  (def robot (sol/make-robot {:x 0 :y 0} :north))
  (sol/move robot "LAAARALA")
  (t/assert-equal {:position {:x -4 :y 1} :direction :west} robot))

(t/deftest "moving west and south"
  (def robot (sol/make-robot {:x 2 :y -7} :east))
  (sol/move robot "RRAAAAALA")
  (t/assert-equal {:position {:x -3 :y -8} :direction :south} robot))

(t/deftest "moving east and north"
  (def robot (sol/make-robot {:x 8 :y 4} :south))
  (sol/move robot "LAAARRRALLLL")
  (t/assert-equal {:position {:x 11 :y 5} :direction :north} robot))

(t/run)
