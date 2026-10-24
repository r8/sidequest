\ The actors: each leaves their cast number.
: amara   ( -- n ) 1 ;
: bastien ( -- n ) 2 ;
: chidi   ( -- n ) 3 ;

\ The role, as a deferred word: whoever plays it leaves their number. Amara plays it at first.
defer hamlet ( -- n )
' amara is hamlet

\ Makes hamlet be played by the actor xt.
: cast ( xt -- )
  is hamlet ;

\ The xt of the actor currently playing hamlet.
: who-plays ( -- xt )
  action-of hamlet ;

\ Runs hamlet once with xt in the role, then gives the role back.
: one-scene ( xt -- n )
  who-plays swap cast  hamlet  swap cast ;

\ Whether the last of lines lines is Amara's when Amara reads next. Deferred, so that
\ bastien-next can call it before it is written.
defer amara-next ( lines -- flag )

\ Whether the last of lines lines is Amara's when Bastien reads next.
: bastien-next ( lines -- flag )
  dup 1 = if drop false exit then  1- amara-next ;

: (amara-next) ( lines -- flag )
  dup 1 = if drop true exit then  1- bastien-next ;
' (amara-next) is amara-next
