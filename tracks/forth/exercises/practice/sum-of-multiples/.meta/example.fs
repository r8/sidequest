\ Sum every number below limit that is a multiple of at least one of the factors, given as an
\ array of n cells. A factor of 0 has no multiples to add:
\   create factors 3 , 5 ,
\   factors 2 10 sum-of-multiples  ( -- 23 )
variable factors  variable #factors

: divides? ( factor n -- flag ) over if swap mod 0= else 2drop false then ;

: multiple? ( n -- flag )
  factors @ #factors @ cells bounds ?do
    i @ over divides? if drop true unloop exit then
  cell +loop drop false ;

\ The numbers below the limit are 1 to limit-1; ?do runs from 1 to 0 all the way round the
\ cell, so a limit below 1 is raised to 1 to give no numbers at all.
: sum-of-multiples ( addr n limit -- sum )
  >r #factors ! factors !
  0 r> 1 max 1 ?do i multiple? if i + then loop ;
