require ../lib/test.fs
require ../coat-check.fs

test" 1. two parties with coats and a bag"  2 1 3 0 combine-claims 1 assert= 5 assert= ;test
test" 1. two parties with bags"  0 2 1 4 combine-claims 6 assert= 1 assert= ;test
test" 1. an empty claim"  4 2 0 0 combine-claims 2 assert= 4 assert= ;test

test" 2. four classes"  20 3 4 scale-claim 12 assert= 80 assert= ;test
test" 2. a single class"  7 2 1 scale-claim 2 assert= 7 assert= ;test
test" 2. no classes"  7 2 0 scale-claim 0 assert= 0 assert= ;test

test" 3. four hooks"  1 2 3 4 shift-hooks 1 assert= 4 assert= 3 assert= 2 assert= ;test
test" 3. other items"  40 30 20 10 shift-hooks 40 assert= 10 assert= 20 assert= 30 assert= ;test

test" 4. the second claim is bigger"  1 1 0 5 bigger-claim 5 assert= 0 assert= ;test
test" 4. the first claim is bigger"  3 1 2 1 bigger-claim 1 assert= 3 assert= ;test
test" 4. a tie goes to the first claim"  2 2 4 0 bigger-claim 2 assert= 2 assert= ;test
test" 4. bags count as much as coats"  0 3 2 0 bigger-claim 3 assert= 0 assert= ;test

end-tests
