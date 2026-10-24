require ../lib/test.fs
require ../trinary.fs

test" trinary 1 is decimal 1"  s" 1" trinary>decimal 1 assert= ;test
test" trinary 2 is decimal 2"  s" 2" trinary>decimal 2 assert= ;test
test" trinary 10 is decimal 3"  s" 10" trinary>decimal 3 assert= ;test
test" trinary 11 is decimal 4"  s" 11" trinary>decimal 4 assert= ;test
test" trinary 100 is decimal 9"  s" 100" trinary>decimal 9 assert= ;test
test" trinary 112 is decimal 14"  s" 112" trinary>decimal 14 assert= ;test
test" trinary 222 is decimal 26"  s" 222" trinary>decimal 26 assert= ;test
test" trinary 1122000120 is decimal 32091"  s" 1122000120" trinary>decimal 32091 assert= ;test
test" invalid trinary digits returns 0"  s" 1234" trinary>decimal 0 assert= ;test
test" invalid word as input returns 0"  s" carrot" trinary>decimal 0 assert= ;test
test" invalid numbers with letters as input returns 0"  s" 0a1b2c" trinary>decimal 0 assert= ;test

end-tests
