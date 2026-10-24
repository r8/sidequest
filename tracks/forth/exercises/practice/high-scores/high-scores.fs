\ The scores are a list ( addr n ) of cells, oldest first. No word changes the list.
\ personal-top-three returns up to three scores, highest first, in a buffer the solution owns,
\ valid until the next call. gforth already has a latest, so this one is latest-score.
\ Throw -24 (invalid numeric argument) from latest-score and personal-best when there are no
\ scores.

: scores ( addr n -- addr n )
  true abort" implement me" ;

: latest-score ( addr n -- score )
  true abort" implement me" ;

: personal-best ( addr n -- score )
  true abort" implement me" ;

: personal-top-three ( addr n -- addr' n' )
  true abort" implement me" ;
