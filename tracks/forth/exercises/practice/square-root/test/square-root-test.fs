require ../lib/test.fs
require ../square-root.fs

test" root of 1"  1 square-root 1 assert= ;test
test" root of 4"  4 square-root 2 assert= ;test
test" root of 25"  25 square-root 5 assert= ;test
test" root of 81"  81 square-root 9 assert= ;test
test" root of 196"  196 square-root 14 assert= ;test
test" root of 65025"  65025 square-root 255 assert= ;test

end-tests
