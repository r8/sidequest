require ../lib/test.fs
require ../crew-roster.fs

\ Each test allocates its records and frees them at the end.
: new-record ( -- addr ) crew-member allocate throw ;
: new-roster ( n -- addr ) crew-member * allocate throw ;

test" 1. a record has room for three cells and a character"
  crew-member 3 cells 1 chars + >= assert-true ;test
test" 1. every field lies inside the record"
  0 member-id cell+ crew-member <= assert-true
  0 member-rank cell+ crew-member <= assert-true
  0 member-shifts cell+ crew-member <= assert-true
  0 member-deck char+ crew-member <= assert-true ;test
test" 1. the fields keep their own values"
  new-record >r
  11 r@ member-id !  22 r@ member-rank !  33 r@ member-shifts !  [char] D r@ member-deck c!
  r@ member-id @ 11 assert=  r@ member-rank @ 22 assert=  r@ member-shifts @ 33 assert=
  r@ member-deck c@ [char] D assert=
  r> free throw ;test

test" 2. enlisting fills in the record"
  new-record >r
  17 2 [char] C r@ enlist
  r@ member-id @ 17 assert=  r@ member-rank @ 2 assert=  r@ member-deck c@ [char] C assert=
  r> free throw ;test
test" 2. a new crew member has worked no shifts"
  new-record >r
  99 r@ member-shifts !  4 1 [char] A r@ enlist  r@ member-shifts @ 0 assert=
  r> free throw ;test

test" 3. a promotion raises the rank by one"
  new-record >r
  17 2 [char] C r@ enlist  r@ promote  r@ member-rank @ 3 assert=
  r> free throw ;test
test" 3. two promotions"
  new-record >r
  5 0 [char] B r@ enlist  r@ promote r@ promote  r@ member-rank @ 2 assert=
  r@ member-id @ 5 assert=
  r> free throw ;test

test" 4. the first record is at the start of the roster"
  3 new-roster >r  r@ 0 crew-at r@ assert=  r> free throw ;test
test" 4. the third record"
  3 new-roster >r  r@ 2 crew-at r@ - crew-member 2 * assert=  r> free throw ;test
test" 4. records do not overlap"
  3 new-roster >r
  0 3 [char] A r@ 0 crew-at enlist  1 4 [char] B r@ 1 crew-at enlist  2 5 [char] C r@ 2 crew-at enlist
  r@ 0 crew-at member-rank @ 3 assert=  r@ 1 crew-at member-deck c@ [char] B assert=
  r@ 2 crew-at member-id @ 2 assert=
  r> free throw ;test

\ A roster of four: ids 101 to 104 with ranks 2, 5, 3 and 5.
: sample-roster ( -- addr )
  4 new-roster >r
  101 2 [char] A r@ 0 crew-at enlist  102 5 [char] B r@ 1 crew-at enlist
  103 3 [char] A r@ 2 crew-at enlist  104 5 [char] C r@ 3 crew-at enlist
  r> ;
test" 5. the highest rank, first on a tie"  sample-roster dup 4 most-senior 102 assert= free throw ;test
test" 5. a roster of one"  sample-roster dup 1 most-senior 101 assert= free throw ;test
test" 5. only the first records count"
  sample-roster dup 3 crew-at promote dup 3 most-senior 102 assert= free throw ;test
test" 5. a promotion changes who is most senior"
  sample-roster dup 3 crew-at promote dup 4 most-senior 104 assert= free throw ;test

end-tests
