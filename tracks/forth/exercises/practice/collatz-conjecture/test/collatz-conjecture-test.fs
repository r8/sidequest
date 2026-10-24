require ../lib/test.fs
require ../collatz-conjecture.fs

test" zero steps for one"  1 steps 0 assert= ;test
test" divide if even"  16 steps 4 assert= ;test
test" even and odd steps"  12 steps 9 assert= ;test
test" large number of even and odd steps"  1000000 steps 152 assert= ;test
test" zero is an error"  0 ['] steps -24 assert-throws ;test
test" negative value is an error"  -15 ['] steps -24 assert-throws ;test

end-tests
