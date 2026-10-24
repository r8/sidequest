\ Convert the digits ( addr n ), cells most significant first, from in-base to out-base:
\   2 digits 3 10 rebase  ( -- addr' n' )
\ The result lives in a buffer the solution owns, valid until the next call; zero (and an
\ empty list of digits) converts to the single digit 0.
\ Throw -24 (invalid numeric argument) when a base is below 2 or a digit is outside 0..in-base-1.
: rebase ( in-base addr n out-base -- addr' n' )
  true abort" implement me" ;
