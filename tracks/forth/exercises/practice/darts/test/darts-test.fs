require ../lib/test.fs
require ../darts.fs

test" Missed target"  -9e 9e score 0 assert= ;test
test" On the outer circle"  0e 10e score 1 assert= ;test
test" On the middle circle"  -5e 0e score 5 assert= ;test
test" On the inner circle"  0e -1e score 10 assert= ;test
test" Exactly on center"  0e 0e score 10 assert= ;test
test" Near the center"  -0.1e -0.1e score 10 assert= ;test
test" Just within the inner circle"  0.7e 0.7e score 10 assert= ;test
test" Just outside the inner circle"  0.8e -0.8e score 5 assert= ;test
test" Just within the middle circle"  -3.5e 3.5e score 5 assert= ;test
test" Just outside the middle circle"  -3.6e -3.6e score 1 assert= ;test
test" Just within the outer circle"  -7e 7e score 1 assert= ;test
test" Just outside the outer circle"  7.1e -7.1e score 0 assert= ;test
test" Asymmetric position between the inner and middle circles"  0.5e -4e score 5 assert= ;test

end-tests
