(import test :as t)
(import ../queen-attack :as sol)

(t/deftest "queen with a valid position"
  (t/assert-equal {:row 2 :column 2} (sol/create 2 2)))

(t/deftest "queen must have positive row"
  (t/assert-error "row not positive" (sol/create -2 2)))

(t/deftest "queen must have row on board"
  (t/assert-error "row not on board" (sol/create 8 4)))

(t/deftest "queen must have positive column"
  (t/assert-error "column not positive" (sol/create 2 -2)))

(t/deftest "queen must have column on board"
  (t/assert-error "column not on board" (sol/create 4 8)))

(t/deftest "cannot attack"
  (t/assert-false (sol/can-attack? {:row 2 :column 4} {:row 6 :column 6})))

(t/deftest "can attack on same row"
  (t/assert-true (sol/can-attack? {:row 2 :column 4} {:row 2 :column 6})))

(t/deftest "can attack on same column"
  (t/assert-true (sol/can-attack? {:row 4 :column 5} {:row 2 :column 5})))

(t/deftest "can attack on first diagonal"
  (t/assert-true (sol/can-attack? {:row 2 :column 2} {:row 0 :column 4})))

(t/deftest "can attack on second diagonal"
  (t/assert-true (sol/can-attack? {:row 2 :column 2} {:row 3 :column 1})))

(t/deftest "can attack on third diagonal"
  (t/assert-true (sol/can-attack? {:row 2 :column 2} {:row 1 :column 1})))

(t/deftest "can attack on fourth diagonal"
  (t/assert-true (sol/can-attack? {:row 1 :column 7} {:row 0 :column 6})))

(t/deftest "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal"
  (t/assert-false (sol/can-attack? {:row 4 :column 1} {:row 2 :column 5})))

(t/run)
