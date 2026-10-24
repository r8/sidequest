require ../lib/test.fs
require ../juggling-act.fs

test" 1. a stage of side 6"  6 stage-area 36 assert= ;test
test" 1. a stage of side 1"  1 stage-area 1 assert= ;test
test" 1. a stage of side 12"  12 stage-area 144 assert= ;test

test" 2. more balls in the left hand"  5 3 hands 2 assert= 8 assert= ;test
test" 2. more balls in the right hand"  2 7 hands -5 assert= 9 assert= ;test
test" 2. the same in both hands"  4 4 hands 0 assert= 8 assert= ;test

test" 3. a pass across and up"  1 2 4 6 squared-distance 25 assert= ;test
test" 3. a pass back down"  4 6 1 2 squared-distance 25 assert= ;test
test" 3. a pass along one line"  3 5 3 9 squared-distance 16 assert= ;test
test" 3. a pass with different x and y distances"  0 0 2 1 squared-distance 5 assert= ;test

test" 4. the spread of three throws"  30 45 38 spread 15 assert= ;test
test" 4. the highest throw first"  50 20 35 spread 30 assert= ;test
test" 4. the lowest throw last"  40 45 10 spread 35 assert= ;test
test" 4. three equal throws"  25 25 25 spread 0 assert= ;test

test" 5. the middle throw last"  30 45 38 middle-throw 38 assert= ;test
test" 5. the middle throw first"  38 30 45 middle-throw 38 assert= ;test
test" 5. the middle throw second"  45 38 30 middle-throw 38 assert= ;test
test" 5. two equal throws"  20 35 20 middle-throw 20 assert= ;test

end-tests
