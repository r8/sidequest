\ The first n rows of Pascal's triangle, flattened row after row into one array of cells:
\   3 pascals-triangle  ( -- addr 6 )  holds  1  1 1  1 2 1
\ Row k (counting from 0) has k+1 numbers, so n rows hold n(n+1)/2 cells. The array lives in a
\ buffer the solution owns, valid until the next call.
\ Throw -24 (invalid numeric argument) when n is negative or more than 64 (larger rows overflow).

64 constant max-rows

\ n(n+1)/2: the number of entries in the first n rows.
: triangular ( n -- u ) dup 1+ * 2/ ;

create triangle max-rows triangular cells allot

: row-start ( k -- addr ) triangular cells triangle + ;
: edge? ( k j -- flag ) dup 0= -rot = or ;

\ Entry j of row k, the sum of the two entries above it in row k-1.
: inner ( k j -- u ) cells swap 1- row-start + dup 1 cells - @ swap @ + ;

: entry ( k j -- u ) 2dup edge? if 2drop 1 else inner then ;

: fill-row ( k -- ) dup 1+ 0 do dup i entry over row-start i cells + ! loop drop ;

: pascals-triangle ( n -- addr len )
  dup 0 max-rows 1+ within 0= if -24 throw then
  dup 0 ?do i fill-row loop  triangle swap triangular ;
