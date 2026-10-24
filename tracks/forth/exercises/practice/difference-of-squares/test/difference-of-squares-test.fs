require ../lib/test.fs
require ../difference-of-squares.fs

test" square of sum 1"  1 square-of-sum 1 assert= ;test
test" square of sum 5"  5 square-of-sum 225 assert= ;test
test" square of sum 100"  100 square-of-sum 25502500 assert= ;test
test" sum of squares 1"  1 sum-of-squares 1 assert= ;test
test" sum of squares 5"  5 sum-of-squares 55 assert= ;test
test" sum of squares 100"  100 sum-of-squares 338350 assert= ;test
test" difference of squares 1"  1 difference-of-squares 0 assert= ;test
test" difference of squares 5"  5 difference-of-squares 170 assert= ;test
test" difference of squares 100"  100 difference-of-squares 25164150 assert= ;test

end-tests
