\ The primes up to and including limit, found with the Sieve of Eratosthenes (no division),
\ as an array of n cells in a buffer the solution owns, valid until the next call:
\   10 primes  ( -- addr 4 )  \ 2 3 5 7
variable sieve   0 sieve !    \ one byte per number 0..limit, nonzero once crossed out
variable found   0 found !    \ the primes, one cell each
variable #found

\ Free the buffer var points at, if any, and allocate a new one of u bytes.
: renew ( var u -- ) over @ ?dup if free throw then  allocate throw swap ! ;

: composite ( n -- c-addr ) sieve @ + ;

: prime, ( p -- ) found @ #found @ cells + !  1 #found +! ;

\ Cross out the multiples of p from p*p up to limit.
: cross-out ( limit p -- limit )
  dup dup * begin ( limit p m ) 2 pick over >= while  1 over composite c!  over +  repeat 2drop ;

: primes ( limit -- addr n )
  0 max  sieve over 1+ renew  sieve @ over 1+ erase
  found over 1+ cells renew  0 #found !
  dup 1+ 2 max 2 ?do  i composite c@ 0= if i prime, i cross-out then  loop drop
  found @ #found @ ;
