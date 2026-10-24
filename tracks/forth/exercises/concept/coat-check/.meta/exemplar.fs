\ The coats and bags of two claims together.
: combine-claims ( coats1 bags1 coats2 bags2 -- coats bags )
  rot + >r + r> ;

\ The coats and bags of n identical claims.
: scale-claim ( coats bags n -- coats' bags' )
  tuck * >r * r> ;

\ Move the first of four items to the end.
: shift-hooks ( a b c d -- b c d a )
  >r rot r> swap ;

\ The claim with more items in total; the first one on a tie.
: bigger-claim ( coats1 bags1 coats2 bags2 -- coats bags )
  2>r  2dup +  2r@ +  >= if  2r> 2drop  else  2drop 2r>  then ;
