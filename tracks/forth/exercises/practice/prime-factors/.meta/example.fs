\ The prime factors of u in ascending order, repeated as often as they divide it, as an array
\ of n cells in a buffer the solution owns, valid until the next call:
\   12 prime-factors  ( -- addr 3 )  \ 2 2 3
create factors 64 cells allot  \ a 64-bit number has at most 64 prime factors
variable #factors

: factor, ( p -- ) factors #factors @ cells + !  1 #factors +! ;

\ Unsigned division: mod and / would read a u with its top bit set as negative.
: u/mod ( u1 u2 -- rem quot ) 0 swap um/mod ;

: divide-out ( n p -- n' p )
  begin 2dup u/mod swap 0= while  rot drop  over factor,  swap repeat drop ;

\ Trial division up to the square root: p <= n/p, which unlike p*p <= n can't overflow. Whatever
\ remains above 1 is itself prime.
: prime-factors ( u -- addr n )
  0 #factors !
  2 begin 2dup u/mod nip over u>= while divide-out 1+ repeat drop
  dup 1 u> if factor, else drop then
  factors #factors @ ;
