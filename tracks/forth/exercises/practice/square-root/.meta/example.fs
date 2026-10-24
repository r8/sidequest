\ The integer square root of a positive perfect square, without the float words:
\   25 square-root  ( -- 5 )

\ One step of Newton's method: y = (x + n/x) / 2.
: improve ( n x -- n x y ) 2dup / over + 2/ ;

: square-root ( n -- root )
  dup begin improve 2dup > while nip repeat drop nip ;
