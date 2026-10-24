require ../lib/test.fs
require ../grains.fs

test" grains on square 1"  1 square 1 assert-u= ;test
test" grains on square 2"  2 square 2 assert-u= ;test
test" grains on square 3"  3 square 4 assert-u= ;test
test" grains on square 4"  4 square 8 assert-u= ;test
test" grains on square 16"  16 square 32768 assert-u= ;test
test" grains on square 32"  32 square 2147483648 assert-u= ;test
test" grains on square 64"  64 square 9223372036854775808 assert-u= ;test
test" square 0 is invalid"  0 ['] square -24 assert-throws ;test
test" negative square is invalid"  -1 ['] square -24 assert-throws ;test
test" square greater than 64 is invalid"  65 ['] square -24 assert-throws ;test
test" returns the total number of grains on the board"  total 18446744073709551615 assert-u= ;test

end-tests
