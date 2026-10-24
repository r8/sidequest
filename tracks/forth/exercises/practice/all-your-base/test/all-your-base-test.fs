require ../lib/test.fs
require ../all-your-base.fs

create bit-one 1 ,
test" single bit one to decimal"  2 bit-one 1 10 rebase bit-one 1 assert-cells= ;test

create bits-101 1 , 0 , 1 ,
create decimal-5 5 ,
test" binary to single decimal"  2 bits-101 3 10 rebase decimal-5 1 assert-cells= ;test
test" single decimal to binary"  10 decimal-5 1 2 rebase bits-101 3 assert-cells= ;test

create bits-101010 1 , 0 , 1 , 0 , 1 , 0 ,
create decimal-42 4 , 2 ,
test" binary to multiple decimal"  2 bits-101010 6 10 rebase decimal-42 2 assert-cells= ;test
test" decimal to binary"  10 decimal-42 2 2 rebase bits-101010 6 assert-cells= ;test

create trits-1120 1 , 1 , 2 , 0 ,
create hex-2a 2 , 10 ,
test" trinary to hexadecimal"  3 trits-1120 4 16 rebase hex-2a 2 assert-cells= ;test
test" hexadecimal to trinary"  16 hex-2a 2 3 rebase trits-1120 4 assert-cells= ;test

create base-97 3 , 46 , 60 ,
create base-73 6 , 10 , 45 ,
test" 15-bit integer"  97 base-97 3 73 rebase base-73 3 assert-cells= ;test

\ A cell with every bit set, as binary digits (8 bits a byte).
8 cells constant cell-bits
create all-ones cell-bits cells allot
: fill-ones ( -- ) all-ones cell-bits cells bounds ?do 1 i ! cell +loop ;
fill-ones
test" every bit of a cell"  2 all-ones cell-bits 2 rebase all-ones cell-bits assert-cells= ;test

create no-digits
create just-zero 0 ,
test" empty list"  2 no-digits 0 10 rebase just-zero 1 assert-cells= ;test
test" single zero"  10 just-zero 1 2 rebase just-zero 1 assert-cells= ;test

create three-zeros 0 , 0 , 0 ,
test" multiple zeros"  10 three-zeros 3 2 rebase just-zero 1 assert-cells= ;test

create leading-zeros 0 , 6 , 0 ,
test" leading zeros"  7 leading-zeros 3 10 rebase decimal-42 2 assert-cells= ;test

: from-base-1 ( -- addr n ) 1 just-zero 1 10 rebase ;
test" input base is one"  ['] from-base-1 -24 assert-xt-throws ;test

: from-base-0 ( -- addr n ) 0 no-digits 0 10 rebase ;
test" input base is zero"  ['] from-base-0 -24 assert-xt-throws ;test

: from-base-minus-2 ( -- addr n ) -2 bit-one 1 10 rebase ;
test" input base is negative"  ['] from-base-minus-2 -24 assert-xt-throws ;test

create negative-digit 1 , -1 , 1 , 0 , 1 , 0 ,
: with-negative-digit ( -- addr n ) 2 negative-digit 6 10 rebase ;
test" negative digit"  ['] with-negative-digit -24 assert-xt-throws ;test

create digit-too-big 1 , 2 , 1 , 0 , 1 , 0 ,
: with-digit-too-big ( -- addr n ) 2 digit-too-big 6 10 rebase ;
test" invalid positive digit"  ['] with-digit-too-big -24 assert-xt-throws ;test

: to-base-1 ( -- addr n ) 2 bits-101010 6 1 rebase ;
test" output base is one"  ['] to-base-1 -24 assert-xt-throws ;test

create decimal-7 7 ,
: to-base-0 ( -- addr n ) 10 decimal-7 1 0 rebase ;
test" output base is zero"  ['] to-base-0 -24 assert-xt-throws ;test

: to-base-minus-7 ( -- addr n ) 2 bit-one 1 -7 rebase ;
test" output base is negative"  ['] to-base-minus-7 -24 assert-xt-throws ;test

: both-bases-negative ( -- addr n ) -2 bit-one 1 -7 rebase ;
test" both bases are negative"  ['] both-bases-negative -24 assert-xt-throws ;test

end-tests
