\ A locker is three cells: the owner, the combination, and a flag that is true when it is open.

\ Lays down a new, closed locker and leaves its address.
: new-locker ( owner combination -- locker )
  here -rot swap , , false , ;

\ The locker's owner.
: owner ( locker -- owner )
  @ ;

\ The locker's combination.
: combination ( locker -- combination )
  cell+ @ ;

\ The address of the locker's open flag.
: open-flag ( locker -- addr )
  2 cells + ;

\ True when the locker is open.
: open? ( locker -- flag )
  open-flag @ ;

\ Opens the locker if the combination is right; true if it opened.
: try-open ( combination locker -- flag )
  tuck combination = dup if true rot open-flag ! else nip then ;

\ Closes the locker.
: lock-up ( locker -- )
  false swap open-flag ! ;

\ Gives the locker a new owner and combination, closed.
: reassign ( owner combination locker -- )
  tuck cell+ !  tuck !  lock-up ;
