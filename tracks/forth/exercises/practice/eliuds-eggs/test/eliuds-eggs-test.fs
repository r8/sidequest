require ../lib/test.fs
require ../eliuds-eggs.fs

test" 0 eggs"  0 egg-count 0 assert= ;test
test" 1 egg"  16 egg-count 1 assert= ;test
test" 4 eggs"  89 egg-count 4 assert= ;test
test" 13 eggs"  2000000000 egg-count 13 assert= ;test

end-tests
