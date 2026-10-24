require ../lib/test.fs
require ../tea-time.fs

test" 1. a kettle for four cups"  4 kettle-minutes 7 assert= ;test
test" 1. a kettle for one cup"  1 kettle-minutes 4 assert= ;test
test" 1. no cups, no kettle"  0 kettle-minutes 0 assert= ;test

test" 2. a few leaves"  2 steep-minutes 2 assert= ;test
test" 2. exactly 3 grams"  3 steep-minutes 3 assert= ;test
test" 2. a usual pot"  5 steep-minutes 3 assert= ;test
test" 2. exactly 6 grams"  6 steep-minutes 3 assert= ;test
test" 2. a strong pot"  8 steep-minutes 4 assert= ;test

test" 3. too hot tea cools to 70"  92 serve-temp 70 assert= ;test
test" 3. cold tea is reheated"  50 serve-temp 85 assert= ;test
test" 3. tea in between is served as it is"  63 serve-temp 63 assert= ;test
test" 3. tea at exactly 70"  70 serve-temp 70 assert= ;test
test" 3. tea at exactly 55"  55 serve-temp 55 assert= ;test

test" 4. a small order"  4 bill 1000 assert= ;test
test" 4. a large order"  12 bill 2700 assert= ;test
test" 4. exactly ten cups"  10 bill 2250 assert= ;test
test" 4. nine cups, without the discount"  9 bill 2250 assert= ;test
test" 4. no cups"  0 bill 0 assert= ;test

end-tests
