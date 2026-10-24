\ A queen is a position on the stack: its row and column, each 0..7.
\ queen validates a position, leaving it unchanged; it throws -24 (invalid numeric argument)
\ when the row or column is negative or off the board.
: on-board? ( n -- flag ) 0 8 within ;

: queen ( row column -- row column )
  2dup on-board? swap on-board? and 0= if -24 throw then ;

\ True when queens at the two positions share a row, column or diagonal.
: can-attack? ( row1 column1 row2 column2 -- flag )
  rot - abs >r  - abs r>  ( row-distance column-distance )
  2dup = >r  * 0=  r> or ;
