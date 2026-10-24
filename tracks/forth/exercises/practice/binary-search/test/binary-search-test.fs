require ../lib/test.fs
require ../binary-search.fs

create just-six 6 ,
test" finds a value in an array with one element"  just-six 1 6 binary-search 0 assert= ;test

create seven-sorted 1 , 3 , 4 , 6 , 8 , 9 , 11 ,
test" finds a value in the middle of an array"  seven-sorted 7 6 binary-search 3 assert= ;test
test" finds a value at the beginning of an array"  seven-sorted 7 1 binary-search 0 assert= ;test
test" finds a value at the end of an array"  seven-sorted 7 11 binary-search 6 assert= ;test

create odd-length 1 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , 233 , 377 , 634 ,
test" finds a value in an array of odd length"  odd-length 13 144 binary-search 9 assert= ;test

create even-length 1 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , 233 , 377 ,
test" finds a value in an array of even length"  even-length 12 21 binary-search 5 assert= ;test

: search-7 ( -- index ) seven-sorted 7 7 binary-search ;
test" identifies that a value is not included in the array"  ['] search-7 -24 assert-xt-throws ;test

: search-0 ( -- index ) seven-sorted 7 0 binary-search ;
test" a value smaller than the array's smallest value is not found"  ['] search-0 -24 assert-xt-throws ;test

: search-13 ( -- index ) seven-sorted 7 13 binary-search ;
test" a value larger than the array's largest value is not found"  ['] search-13 -24 assert-xt-throws ;test

create no-values
: search-empty ( -- index ) no-values 0 1 binary-search ;
test" nothing is found in an empty array"  ['] search-empty -24 assert-xt-throws ;test

create one-two 1 , 2 ,
: search-crossed ( -- index ) one-two 2 0 binary-search ;
test" nothing is found when the left and right bounds cross"  ['] search-crossed -24 assert-xt-throws ;test

end-tests
