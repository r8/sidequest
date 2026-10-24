\ Forth has no nested arrays, so a nested array is written as a flat stream of cells in which
\ two marker values open and close a nested array and a third stands for null:
\   [1, [2, null], 3]  is  create input  1 , <[ , 2 , null , ]> , 3 ,
\ flatten takes such a stream ( addr n ) and returns just the numbers, in order, in a buffer of
\ 256 cells the solution owns, valid until the next call. The markers are the three most
\ negative cell values, so those can't appear as numbers.

0 invert 1 rshift invert constant <[   \ the most negative cell
<[ 1+ constant ]>
<[ 2 + constant null

256 constant max-items
create flat max-items cells allot
variable #flat

: marker? ( x -- flag ) <[ null 1+ within ;

: flat, ( x -- )
  #flat @ max-items = if -24 throw then
  flat #flat @ cells + !  1 #flat +! ;

: flatten ( addr n -- addr' n' )
  0 #flat !  cells bounds ?do i @ dup marker? if drop else flat, then cell +loop
  flat #flat @ ;
