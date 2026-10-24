\ The n-by-n spiral, numbered clockwise from 1 at the top left, as one flat array of n*n cells,
\ row after row:
\   2 spiral-matrix  ( -- addr 4 )  holds  1 2  4 3
\ The array lives in a buffer the solution owns, valid until the next call.
\ Throw -24 (invalid numeric argument) when n is negative or more than 32.

32 constant max-size
create grid max-size dup * cells allot
variable size
variable row  variable col      \ the current position
variable drow  variable dcol    \ the direction of travel

: square ( r c -- addr ) swap size @ * + cells grid + ;
: inside? ( r c -- flag ) size @ tuck u< -rot u< and ;
: free? ( r c -- flag ) 2dup inside? if square @ 0= else 2drop false then ;
: next-square ( -- r c ) row @ drow @ +  col @ dcol @ + ;
: turn-right ( -- ) dcol @  drow @ negate dcol !  drow ! ;
: advance ( -- ) next-square free? 0= if turn-right then  next-square col ! row ! ;

: start ( n -- )
  size !  grid max-size dup * cells erase
  0 row !  0 col !  0 drow !  1 dcol ! ;

: spiral-matrix ( n -- addr n*n )
  dup 0 max-size 1+ within 0= if -24 throw then
  dup start  dup *
  dup 1+ 1 ?do  i row @ col @ square !  i over < if advance then  loop
  grid swap ;
