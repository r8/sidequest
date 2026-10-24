\ The scores are a list ( addr n ) of cells, oldest first. No word changes the list.
\ personal-top-three returns up to three scores, highest first, in a buffer the solution owns,
\ valid until the next call. gforth already has a latest, so this one is latest-score.
\ Throw -24 (invalid numeric argument) from latest-score and personal-best when there are no
\ scores.

: ?scores ( addr n -- addr n ) dup 0= if -24 throw then ;

\ The list itself: it is never reordered.
: scores ( addr n -- addr n ) ;

: latest-score ( addr n -- score ) ?scores 1- cells + @ ;

: personal-best ( addr n -- score )
  ?scores over @ -rot cells bounds ?do i @ max cell +loop ;

\ The best scores so far, highest first, with a spare fourth slot that new scores enter at.
create top 4 cells allot
variable #top

: top-slot ( i -- addr ) cells top + ;

\ Moves the score up past every lower one, then keeps at most three.
: rank ( score -- )
  #top @
  begin dup if 2dup 1- top-slot @ > else false then while
    dup 1- top-slot @ over top-slot !  1-
  repeat top-slot !
  #top @ 1+ 3 min #top ! ;

: personal-top-three ( addr n -- addr' n' )
  0 #top !  cells bounds ?do i @ rank cell +loop  top #top @ ;
