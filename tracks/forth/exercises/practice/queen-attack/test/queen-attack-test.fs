require ../lib/test.fs
require ../queen-attack.fs

test" Test creation of Queens with valid and invalid positions > queen with a valid position"  2 2 queen 2 assert= 2 assert= ;test

: negative-row ( -- row column ) -2 2 queen ;
test" Test creation of Queens with valid and invalid positions > queen must have positive row"  ['] negative-row -24 assert-xt-throws ;test

: row-off-board ( -- row column ) 8 4 queen ;
test" Test creation of Queens with valid and invalid positions > queen must have row on board"  ['] row-off-board -24 assert-xt-throws ;test

: negative-column ( -- row column ) 2 -2 queen ;
test" Test creation of Queens with valid and invalid positions > queen must have positive column"  ['] negative-column -24 assert-xt-throws ;test

: column-off-board ( -- row column ) 4 8 queen ;
test" Test creation of Queens with valid and invalid positions > queen must have column on board"  ['] column-off-board -24 assert-xt-throws ;test

test" Test the ability of one queen to attack another > cannot attack"  2 4 queen 6 6 queen can-attack? assert-false ;test
test" Test the ability of one queen to attack another > can attack on same row"  2 4 queen 2 6 queen can-attack? assert-true ;test
test" Test the ability of one queen to attack another > can attack on same column"  4 5 queen 2 5 queen can-attack? assert-true ;test
test" Test the ability of one queen to attack another > can attack on first diagonal"  2 2 queen 0 4 queen can-attack? assert-true ;test
test" Test the ability of one queen to attack another > can attack on second diagonal"  2 2 queen 3 1 queen can-attack? assert-true ;test
test" Test the ability of one queen to attack another > can attack on third diagonal"  2 2 queen 1 1 queen can-attack? assert-true ;test
test" Test the ability of one queen to attack another > can attack on fourth diagonal"  1 7 queen 0 6 queen can-attack? assert-true ;test
test" Test the ability of one queen to attack another > cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal"
  4 1 queen 2 5 queen can-attack? assert-false ;test

end-tests
