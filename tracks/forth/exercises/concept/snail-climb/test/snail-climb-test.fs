require ../lib/test.fs
require ../snail-climb.fs

test" 1. a four-digit number"  4096 digit-count 4 assert= ;test
test" 1. a single digit"  7 digit-count 1 assert= ;test
test" 1. zero"  0 digit-count 1 assert= ;test
test" 1. ten"  10 digit-count 2 assert= ;test
test" 1. a million"  1000000 digit-count 7 assert= ;test

test" 2. a long trail"  40 5 dry-hours 4 assert= ;test
test" 2. a trail that is already dry"  3 5 dry-hours 0 assert= ;test
test" 2. a trail exactly at the limit"  16 16 dry-hours 1 assert= ;test
test" 2. a trail that must dry completely"  100 1 dry-hours 7 assert= ;test

test" 3. a deep well"  10 3 climb-days 5 assert= ;test
test" 3. a well climbed in one day"  3 3 climb-days 1 assert= ;test
test" 3. a slow snail"  5 2 climb-days 4 assert= ;test
test" 3. a fast snail in a deep well"  20 5 climb-days 5 assert= ;test

test" 4. after day 5"  5 next-feast-day 9 assert= ;test
test" 4. after a feast day"  9 next-feast-day 16 assert= ;test
test" 4. before the season starts"  0 next-feast-day 1 assert= ;test
test" 4. after day 1"  1 next-feast-day 4 assert= ;test
test" 4. after day 99"  99 next-feast-day 100 assert= ;test

end-tests
