\ The n-by-n spiral, numbered clockwise from 1 at the top left, as one flat array of n*n cells,
\ row after row:
\   2 spiral-matrix  ( -- addr 4 )  holds  1 2  4 3
\ The array lives in a buffer the solution owns, valid until the next call.
\ Throw -24 (invalid numeric argument) when n is negative or more than 32.
: spiral-matrix ( n -- addr n*n )
  true abort" implement me" ;
