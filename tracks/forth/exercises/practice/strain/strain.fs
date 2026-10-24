\ keep and discard take a list ( addr n ) of cells and a predicate xt ( x -- flag ), and return
\ the elements for which the predicate is true (keep) or false (discard), in their original
\ order. A cell can hold anything: a number, the address of a counted string (c" zebra"), or the
\ address of a counted list (a cell with the count, then the elements). The result lives in a
\ buffer of 256 cells the solution owns, valid until the next keep or discard.

: keep ( addr n xt -- addr' n' )
  true abort" implement me" ;

: discard ( addr n xt -- addr' n' )
  true abort" implement me" ;
