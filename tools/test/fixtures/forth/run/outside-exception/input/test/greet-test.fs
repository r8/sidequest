require ../lib/test.fs
require ../greet.fs

test" runs"  21 double 42 assert= ;test
-10 throw
test" never"  21 double 42 assert= ;test

end-tests
