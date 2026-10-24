\ A locker is three cells: the owner, the combination, and a flag that is true when it is open.

\ Lays down a new, closed locker and leaves its address.
: new-locker ( owner combination -- locker )
  true abort" implement me" ;

\ The locker's owner.
: owner ( locker -- owner )
  true abort" implement me" ;

\ The locker's combination.
: combination ( locker -- combination )
  true abort" implement me" ;

\ True when the locker is open.
: open? ( locker -- flag )
  true abort" implement me" ;

\ Opens the locker if the combination is right; true if it opened.
: try-open ( combination locker -- flag )
  true abort" implement me" ;

\ Closes the locker.
: lock-up ( locker -- )
  true abort" implement me" ;

\ Gives the locker a new owner and combination, closed.
: reassign ( owner combination locker -- )
  true abort" implement me" ;
