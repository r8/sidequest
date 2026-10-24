\ Throw -24 (invalid numeric argument) for a square outside 1..64.
: square ( n -- u )
  dup 1 65 within 0= if -24 throw then
  1 swap 1- lshift ;

\ Every bit of a 64-bit cell set: 2^64 - 1.
: total ( -- u ) 0 invert ;
