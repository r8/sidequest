\ A list is ( addr n ): n cells at addr. A list whose elements are lists holds, in each cell,
\ the address of a counted list: a cell with the count followed by that many cells, as
\   create evens 3 , 2 , 4 , 6 ,
\ builds. Words that return a list leave it in a buffer of 256 cells the solution owns (one
\ buffer per word), valid until the next call of that word. Function arguments are execution
\ tokens:  ( x -- flag ) for filter, ( x -- y ) for map, ( acc x -- acc' ) for the folds.
\ gforth already has an append, so this one is append-lists.

: append-lists ( addr1 n1 addr2 n2 -- addr n )
  true abort" implement me" ;

\ lists is an array of n counted-list addresses; the result holds all their elements in order.
: concat ( lists n -- addr n )
  true abort" implement me" ;

: filter ( addr n xt -- addr' n' )
  true abort" implement me" ;

: length ( addr n -- n )
  true abort" implement me" ;

: map ( addr n xt -- addr' n )
  true abort" implement me" ;

: foldl ( addr n acc xt -- acc' )
  true abort" implement me" ;

\ Folds from the last element to the first; xt still takes ( acc x -- acc' ).
: foldr ( addr n acc xt -- acc' )
  true abort" implement me" ;

: reverse ( addr n -- addr' n )
  true abort" implement me" ;
