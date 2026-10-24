require ../lib/test.fs
require ../nesting-dolls.fs

test" 1. no dolls can be lined up one way"  0 arrangements 1 assert= ;test
test" 1. one doll can be lined up one way"  1 arrangements 1 assert= ;test
test" 1. three dolls"  3 arrangements 6 assert= ;test
test" 1. five dolls"  5 arrangements 120 assert= ;test
test" 1. ten dolls"  10 arrangements 3628800 assert= ;test

test" 2. a set of nine centimetres"  9 layers 5 assert= ;test
test" 2. a single tiny doll"  1 layers 1 assert= ;test
test" 2. nothing to carve"  0 layers 0 assert= ;test
test" 2. a set of thirty centimetres"  30 layers 8 assert= ;test

test" 3. a twelve by eight board"  12 8 largest-square 4 assert= ;test
test" 3. an eight by twelve board"  8 12 largest-square 4 assert= ;test
test" 3. sides with no common divisor"  7 5 largest-square 1 assert= ;test
test" 3. a square board"  9 9 largest-square 9 assert= ;test
test" 3. a twenty-one by six board"  21 6 largest-square 3 assert= ;test

test" 4. two dolls in each, two levels down"  2 2 family-size 7 assert= ;test
test" 4. depth zero is a single doll"  3 0 family-size 1 assert= ;test
test" 4. one doll in each is an ordinary set"  1 4 family-size 5 assert= ;test
test" 4. three dolls in each, two levels down"  3 2 family-size 13 assert= ;test
test" 4. two dolls in each, three levels down"  2 3 family-size 15 assert= ;test

end-tests
