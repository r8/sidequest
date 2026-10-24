require ../lib/test.fs
require ../greet.fs

test" passes"  21 double 42 assert= ;test
test" fails on a number"  2 double 5 assert= ;test
test" fails on a missing throw"  1 ['] double -24 assert-throws ;test
test" leaves the stack dirty"  1 double ;test

end-tests
