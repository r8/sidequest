require ../lib/test.fs
require ../roller-coaster.fs

test" 1. a tall rider"  125 tall-enough? assert-true ;test
test" 1. a short rider"  110 tall-enough? assert-false ;test
test" 1. a rider exactly at the minimum"  120 tall-enough? assert-true ;test
test" 1. a rider just below the minimum"  119 tall-enough? assert-false ;test

test" 2. a rider in the middle of the range"  160 fits-the-seat? assert-true ;test
test" 2. a rider at the tallest the seat allows"  195 fits-the-seat? assert-true ;test
test" 2. a rider too tall for the seat"  196 fits-the-seat? assert-false ;test
test" 2. a rider at the shortest the seat allows"  120 fits-the-seat? assert-true ;test
test" 2. a rider too short for the seat"  119 fits-the-seat? assert-false ;test

test" 3. a rider who fits and is old enough"  140 9 may-ride? assert-true ;test
test" 3. a rider who fits but is too young"  140 7 may-ride? assert-false ;test
test" 3. a rider just old enough"  130 8 may-ride? assert-true ;test
test" 3. a rider old enough but too short"  115 30 may-ride? assert-false ;test
test" 3. a rider old enough but too tall"  200 30 may-ride? assert-false ;test

test" 4. the second rider is old enough"  12 17 ride-together? assert-true ;test
test" 4. the first rider is old enough"  40 9 ride-together? assert-true ;test
test" 4. neither rider is old enough"  12 15 ride-together? assert-false ;test
test" 4. a rider exactly 16"  16 10 ride-together? assert-true ;test

test" 5. two of three riders"  true false true riders 2 assert= ;test
test" 5. no riders"  false false false riders 0 assert= ;test
test" 5. all three riders"  true true true riders 3 assert= ;test
test" 5. the last rider only"  false false true riders 1 assert= ;test

end-tests
