\ The first n rows of Pascal's triangle, flattened row after row into one array of cells:
\   3 pascals-triangle  ( -- addr 6 )  holds  1  1 1  1 2 1
\ Row k (counting from 0) has k+1 numbers, so n rows hold n(n+1)/2 cells. The array lives in a
\ buffer the solution owns, valid until the next call.
\ Throw -24 (invalid numeric argument) when n is negative or more than 64 (larger rows overflow).
: pascals-triangle ( n -- addr len )
  true abort" implement me" ;
