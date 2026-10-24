require ../lib/test.fs
require ../series.fs

test" slices of one from one"  s" 1" 1 slices s" 1" assert-str= ;test
test" slices of one from two"  s" 12" 1 slices s" 1 2" assert-str= ;test
test" slices of two"  s" 35" 2 slices s" 35" assert-str= ;test
test" slices of two overlap"  s" 9142" 2 slices s" 91 14 42" assert-str= ;test
test" slices can include duplicates"  s" 777777" 3 slices s" 777 777 777 777" assert-str= ;test
test" slices of a long series"  s" 918493904243" 5 slices s" 91849 18493 84939 49390 93904 39042 90424 04243" assert-str= ;test
: slice-length-is-too-large ( -- ) s" 12345" 6 slices ;
test" slice length is too large"  ['] slice-length-is-too-large -24 assert-xt-throws ;test
: slice-length-is-way-too-large ( -- ) s" 12345" 42 slices ;
test" slice length is way too large"  ['] slice-length-is-way-too-large -24 assert-xt-throws ;test
: slice-length-cannot-be-zero ( -- ) s" 12345" 0 slices ;
test" slice length cannot be zero"  ['] slice-length-cannot-be-zero -24 assert-xt-throws ;test
: slice-length-cannot-be-negative ( -- ) s" 123" -1 slices ;
test" slice length cannot be negative"  ['] slice-length-cannot-be-negative -24 assert-xt-throws ;test
: empty-series-is-invalid ( -- ) s" " 1 slices ;
test" empty series is invalid"  ['] empty-series-is-invalid -24 assert-xt-throws ;test

\ Not in the canonical data: more slices than any fixed-size buffer a solution might reach for.
create long-series 200 chars allot  long-series 200 char 1 fill
create long-slices 10200 chars allot  long-slices 10200 char 1 fill
: space-slices ( -- ) 10200 100 do  bl long-slices i chars + c!  101 +loop ;  space-slices
test" many long slices"  long-series 200 100 slices long-slices 10200 assert-str= ;test

end-tests
