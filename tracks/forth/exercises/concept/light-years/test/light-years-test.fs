require ../lib/test.fs
require ../light-years.fs

\ Two doubles are equal when both their cells are: the high cells first, then the low ones.
: assert-d= ( d-actual d-expected -- ) rot swap assert= assert-u= ;

test" 1. one light year"  1 light-years>km 9460730472581. assert-d= ;test
test" 1. no distance"  0 light-years>km 0. assert-d= ;test
test" 1. a million light years"  1000000 light-years>km 9460730472581000000. assert-d= ;test
test" 1. the Andromeda galaxy"  2537000 light-years>km 24001873208937997000. assert-d= ;test

test" 2. five kilometres"  5. km>metres 5000. assert-d= ;test
test" 2. no kilometres"  0. km>metres 0. assert-d= ;test
test" 2. the Andromeda galaxy"  24001873208937997000. km>metres 24001873208937997000000. assert-d= ;test

test" 3. to the moon and back"  384400. round-trip 768800. assert-d= ;test
test" 3. a short hop"  7. round-trip 14. assert-d= ;test
test" 3. a round trip past one cell"  9460730472581000000. round-trip 18921460945162000000. assert-d= ;test

test" 4. a galaxy is farther than a star"  2537000 light-years>km 4 light-years>km farther? assert-true ;test
test" 4. a star is not farther than a galaxy"  4. 24001873208937997000. farther? assert-false ;test
test" 4. the same distance is not farther"  384400. 384400. farther? assert-false ;test
test" 4. distances past one cell"  24001873208937997001. 24001873208937997000. farther? assert-true ;test

test" 5. one light year at light speed"  9460730472581. 25902068371 travel-days 365 assert= ;test
test" 5. a part day is left out"  100. 7 travel-days 14 assert= ;test
test" 5. the Andromeda galaxy"  24001873208937997000. 1000000000 travel-days 24001873208 assert= ;test

end-tests
