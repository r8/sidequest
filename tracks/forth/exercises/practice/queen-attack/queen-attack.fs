\ A queen is a position on the stack: its row and column, each 0..7.
\ queen validates a position, leaving it unchanged; it throws -24 (invalid numeric argument)
\ when the row or column is negative or off the board.
: queen ( row column -- row column )
  true abort" implement me" ;

\ True when queens at the two positions share a row, column or diagonal.
: can-attack? ( row1 column1 row2 column2 -- flag )
  true abort" implement me" ;
