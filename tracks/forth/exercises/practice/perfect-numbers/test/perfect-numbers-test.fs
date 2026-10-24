require ../lib/test.fs
require ../perfect-numbers.fs

test" Perfect numbers > Smallest perfect number is classified correctly"  6 classify perfect assert= ;test
test" Perfect numbers > Medium perfect number is classified correctly"  28 classify perfect assert= ;test
test" Perfect numbers > Large perfect number is classified correctly"  33550336 classify perfect assert= ;test
test" Abundant numbers > Smallest abundant number is classified correctly"  12 classify abundant assert= ;test
test" Abundant numbers > Medium abundant number is classified correctly"  30 classify abundant assert= ;test
test" Abundant numbers > Large abundant number is classified correctly"  33550335 classify abundant assert= ;test
test" Abundant numbers > Perfect square abundant number is classified correctly"  196 classify abundant assert= ;test
test" Deficient numbers > Smallest prime deficient number is classified correctly"  2 classify deficient assert= ;test
test" Deficient numbers > Smallest non-prime deficient number is classified correctly"  4 classify deficient assert= ;test
test" Deficient numbers > Medium deficient number is classified correctly"  32 classify deficient assert= ;test
test" Deficient numbers > Large deficient number is classified correctly"  33550337 classify deficient assert= ;test
test" Deficient numbers > Edge case (no factors other than itself) is classified correctly"  1 classify deficient assert= ;test
test" Invalid inputs > Zero is rejected (as it is not a positive integer)"  0 ['] classify -24 assert-throws ;test
test" Invalid inputs > Negative integer is rejected (as it is not a positive integer)"  -1 ['] classify -24 assert-throws ;test

end-tests
