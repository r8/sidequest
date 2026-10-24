\ The matrix is a string ( c-addr u ) of rows separated by newlines, the numbers in a row by
\ spaces:  s\" 1 2\n3 4"  is a 2-by-2 matrix. row and column take a 1-based index and return that
\ row or column as an array of cells, in a buffer the solution owns, valid until the next call.
\ Throw -24 (invalid numeric argument) when the index is out of range.

: row ( c-addr u i -- addr n )
  true abort" implement me" ;

: column ( c-addr u i -- addr n )
  true abort" implement me" ;
