require ../lib/test.fs
require ../weather-station.fs

test" 1. February"  2 days-in-month 28 assert= ;test
test" 1. September"  9 days-in-month 30 assert= ;test
test" 1. November"  11 days-in-month 30 assert= ;test
test" 1. January"  1 days-in-month 31 assert= ;test
test" 1. December"  12 days-in-month 31 assert= ;test

test" 2. no rain"  0 rain-mm 0 assert= ;test
test" 2. drizzle"  1 rain-mm 1 assert= ;test
test" 2. light rain"  2 rain-mm 4 assert= ;test
test" 2. heavy rain"  3 rain-mm 16 assert= ;test
test" 2. a faulty gauge"  7 rain-mm -1 assert= ;test

test" 3. after April"  4 next-month 5 assert= ;test
test" 3. after January"  1 next-month 2 assert= ;test
test" 3. after December"  12 next-month 1 assert= ;test

test" 4. February in a leap year"  true 2 month-length 29 assert= ;test
test" 4. February in another year"  false 2 month-length 28 assert= ;test
test" 4. June in a leap year"  true 6 month-length 30 assert= ;test
test" 4. March in a leap year"  true 3 month-length 31 assert= ;test
test" 4. April in another year"  false 4 month-length 30 assert= ;test

end-tests
