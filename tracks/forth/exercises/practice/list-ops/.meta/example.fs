\ A list is ( addr n ): n cells at addr. A list whose elements are lists holds, in each cell,
\ the address of a counted list: a cell with the count followed by that many cells, as
\   create evens 3 , 2 , 4 , 6 ,
\ builds. Words that return a list leave it in a buffer of 256 cells the solution owns (one
\ buffer per word), valid until the next call of that word. Function arguments are execution
\ tokens:  ( x -- flag ) for filter, ( x -- y ) for map, ( acc x -- acc' ) for the folds.
\ gforth already has an append, so this one is append-lists.

256 constant max-items

\ A result buffer is itself a counted list with room for max-items cells.
: list-buffer ( "name" -- ) create 0 , max-items cells allot ;
: items ( counted-list -- addr n ) dup cell+ swap @ ;
: reset ( buf -- ) 0 swap ! ;
: push ( x buf -- )
  dup @ max-items = if -24 throw then
  tuck items cells + !  1 swap +! ;
: push-all ( addr n buf -- ) -rot cells bounds ?do i @ over push cell +loop drop ;

list-buffer appended  list-buffer joined  list-buffer filtered  list-buffer mapped  list-buffer reversed

: append-lists ( addr1 n1 addr2 n2 -- addr n )
  appended reset  2swap appended push-all  appended push-all  appended items ;

\ lists is an array of n counted-list addresses; the result holds all their elements in order.
: concat ( lists n -- addr n )
  joined reset  cells bounds ?do i @ items joined push-all cell +loop  joined items ;

: filter ( addr n xt -- addr' n' )
  filtered reset  -rot cells bounds ?do
    i @ dup 2 pick execute if filtered push else drop then
  cell +loop drop  filtered items ;

: length ( addr n -- n ) nip ;

: map ( addr n xt -- addr' n )
  mapped reset  -rot cells bounds ?do i @ over execute mapped push cell +loop drop  mapped items ;

\ Applies xt, kept below the accumulator, to the accumulator and the cell at addr.
: fold-step ( xt acc addr -- xt acc' ) @ 2 pick execute ;

: foldl ( addr n acc xt -- acc' )
  swap 2swap cells bounds ?do i fold-step cell +loop nip ;

\ Folds from the last element to the first; xt still takes ( acc x -- acc' ). The loop runs from
\ the last element's address down to the first's, so it is a do, not a ?do: with one element they
\ are the same address, and ?do would skip it.
: foldr ( addr n acc xt -- acc' )
  swap 2swap ?dup 0= if drop nip exit then
  over swap 1- cells +  do i fold-step [ -1 cells ] literal +loop nip ;

: reverse ( addr n -- addr' n )
  reversed reset  tuck 1- cells + swap 0 ?do dup @ reversed push 1 cells - loop drop
  reversed items ;
