require ../lib/test.fs
require ../kindergarten-garden.fs

\ Compares the four plants a student gets with the four expected ones, in order.
: assert-plants ( p1 p2 p3 p4 e1 e2 e3 e4 -- )
  4 roll swap assert=  3 roll swap assert=  2 roll swap assert=  assert= ;

test" partial garden > garden with single student"
  s\" RC\nGG" s" Alice" plants  radishes clover grass grass assert-plants ;test
test" partial garden > different garden with single student"
  s\" VC\nRC" s" Alice" plants  violets clover radishes clover assert-plants ;test
test" partial garden > garden with two students"
  s\" VVCG\nVVRC" s" Bob" plants  clover grass radishes clover assert-plants ;test
test" partial garden > multiple students for the same garden with three students > second student's garden"
  s\" VVCCGG\nVVCCGG" s" Bob" plants  clover clover clover clover assert-plants ;test
test" partial garden > multiple students for the same garden with three students > third student's garden"
  s\" VVCCGG\nVVCCGG" s" Charlie" plants  grass grass grass grass assert-plants ;test
: full-garden ( -- c-addr u ) s\" VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" ;
test" full garden > for Alice, first student's garden"
  full-garden s" Alice" plants  violets radishes violets radishes assert-plants ;test
test" full garden > for Bob, second student's garden"
  full-garden s" Bob" plants  clover grass clover clover assert-plants ;test
test" full garden > for Charlie"
  full-garden s" Charlie" plants  violets violets clover grass assert-plants ;test
test" full garden > for David"
  full-garden s" David" plants  radishes violets clover radishes assert-plants ;test
test" full garden > for Eve"
  full-garden s" Eve" plants  clover grass radishes grass assert-plants ;test
test" full garden > for Fred"
  full-garden s" Fred" plants  grass clover violets clover assert-plants ;test
test" full garden > for Ginny"
  full-garden s" Ginny" plants  clover grass grass clover assert-plants ;test
test" full garden > for Harriet"
  full-garden s" Harriet" plants  violets radishes radishes violets assert-plants ;test
test" full garden > for Ileana"
  full-garden s" Ileana" plants  grass clover violets clover assert-plants ;test
test" full garden > for Joseph"
  full-garden s" Joseph" plants  violets clover violets grass assert-plants ;test
test" full garden > for Kincaid, second to last student's garden"
  full-garden s" Kincaid" plants  grass clover clover grass assert-plants ;test
test" full garden > for Larry, last student's garden"
  full-garden s" Larry" plants  grass violets clover violets assert-plants ;test

end-tests
