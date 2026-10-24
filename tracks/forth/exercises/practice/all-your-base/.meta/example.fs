\ Convert the digits ( addr n ), cells most significant first, from in-base to out-base:
\   2 digits 3 10 rebase  ( -- addr' n' )
\ The result lives in a buffer the solution owns, valid until the next call; zero (and an
\ empty list of digits) converts to the single digit 0.
\ Throw -24 (invalid numeric argument) when a base is below 2 or a digit is outside 0..in-base-1.

\ Enough for any cell in base 2; the digits are written backwards from the end.
64 constant max-digits
create out-digits max-digits cells allot
out-digits max-digits cells + constant out-end

: ?base ( base -- base ) dup 2 < if -24 throw then ;

: ?digits ( base addr n -- base addr n )
  2dup cells bounds ?do i @ 0 4 pick within 0= if -24 throw then cell +loop ;

: digits>u ( base addr n -- u )
  0 -rot cells bounds ?do over * i @ + cell +loop nip ;

: prepend ( addr n digit -- addr' n' ) rot 1 cells - tuck ! swap 1+ ;

\ Unsigned division: /mod would read a cell with its top bit set as negative and never reach 0.
: u>digits ( u base -- addr n )
  >r out-end 0 rot
  begin 0 r@ um/mod >r prepend r> dup 0= until
  drop rdrop ;

: rebase ( in-base addr n out-base -- addr' n' )
  ?base >r  rot ?base -rot  ?digits digits>u  r> u>digits ;
