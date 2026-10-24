\ The actors: each leaves their cast number.
: amara   ( -- n ) 1 ;
: bastien ( -- n ) 2 ;
: chidi   ( -- n ) 3 ;

\ The role, as a deferred word: whoever plays it leaves their number. Amara plays it at first.
: hamlet ( -- n )
  true abort" implement me" ;

\ Makes hamlet be played by the actor xt.
: cast ( xt -- )
  true abort" implement me" ;

\ The xt of the actor currently playing hamlet.
: who-plays ( -- xt )
  true abort" implement me" ;

\ Runs hamlet once with xt in the role, then gives the role back.
: one-scene ( xt -- n )
  true abort" implement me" ;

\ Whether the last of lines lines is Amara's when Amara reads next.
: amara-next ( lines -- flag )
  true abort" implement me" ;

\ Whether the last of lines lines is Amara's when Bastien reads next.
: bastien-next ( lines -- flag )
  true abort" implement me" ;
