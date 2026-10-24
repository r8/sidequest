require ../lib/test.fs
require ../greet.fs

test" stub aborts"  greet s" Hello, you!" assert-str= ;test
test" bad memory access"  -8 @ drop ;test
test" floats"  2.505e 2.5e assert-f~ ;test

end-tests
