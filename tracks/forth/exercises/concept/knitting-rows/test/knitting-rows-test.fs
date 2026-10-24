require ../lib/test.fs
require ../knitting-rows.fs

test" 1. a shawl of four rows"  4 shawl-stitches 10 assert= ;test
test" 1. a shawl of one row"  1 shawl-stitches 1 assert= ;test
test" 1. a shawl of ten rows"  10 shawl-stitches 55 assert= ;test
test" 1. no shawl at all"  0 shawl-stitches 0 assert= ;test

test" 2. a sleeve of three rows"  3 10 sleeve-stitches 36 assert= ;test
test" 2. a sleeve of one row"  1 20 sleeve-stitches 20 assert= ;test
test" 2. a sleeve starting with one stitch"  5 1 sleeve-stitches 25 assert= ;test
test" 2. a sleeve of no rows"  0 20 sleeve-stitches 0 assert= ;test

test" 3. a toe ending in a single stitch"  10 3 decrease-stitches 22 assert= ;test
test" 3. a toe whose last row has the step"  9 3 decrease-stitches 18 assert= ;test
test" 3. a toe of one row"  5 5 decrease-stitches 5 assert= ;test
test" 3. a toe losing one stitch a row"  6 1 decrease-stitches 21 assert= ;test

test" 4. yarn for exactly three rows"  36 10 rows-from-ball 3 assert= ;test
test" 4. yarn running out partway"  35 10 rows-from-ball 2 assert= ;test
test" 4. not enough yarn for a row"  5 10 rows-from-ball 0 assert= ;test
test" 4. a long thin sleeve"  100 1 rows-from-ball 10 assert= ;test

test" 5. a blanket of two by two"  2 2 checker-squares 2 assert= ;test
test" 5. a blanket of three by three"  3 3 checker-squares 5 assert= ;test
test" 5. a single square"  1 1 checker-squares 1 assert= ;test
test" 5. a blanket of four by three"  4 3 checker-squares 6 assert= ;test
test" 5. a blanket of five by one"  5 1 checker-squares 3 assert= ;test

end-tests
