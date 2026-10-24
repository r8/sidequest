\ keep and discard take a list ( addr n ) of cells and a predicate xt ( x -- flag ), and return
\ the elements for which the predicate is true (keep) or false (discard), in their original
\ order. A cell can hold anything: a number, the address of a counted string (c" zebra"), or the
\ address of a counted list (a cell with the count, then the elements). The result lives in a
\ buffer of 256 cells the solution owns, valid until the next keep or discard.

256 constant max-items
create results max-items cells allot
variable #results

: result, ( x -- )
  #results @ max-items = if -24 throw then
  results #results @ cells + !  1 #results +! ;

\ Keeps the elements whose predicate result, as a well-formed flag, equals wanted.
: sift ( addr n xt wanted -- addr' n' )
  0 #results !  2swap cells bounds ?do
    i @ 2 pick execute 0<> over = if i @ result, then
  cell +loop 2drop  results #results @ ;

: keep ( addr n xt -- addr' n' ) true sift ;

: discard ( addr n xt -- addr' n' ) false sift ;
