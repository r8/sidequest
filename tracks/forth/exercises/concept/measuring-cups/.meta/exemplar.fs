\ Defines name ( n -- ml ), converting n of a unit of ml millilitres.
: unit ( ml "name" -- )
  create ,
  does> ( n -- ml ) @ * ;

\ Defines name ( -- n ), leaving 1, 2, 3, … on successive uses.
: counter ( "name" -- )
  create 0 ,
  does> ( -- n ) 1 over +! @ ;

\ Sets the counter xt back to the start, so its next use leaves 1.
: reset-counter ( xt -- )
  >body 0 swap ! ;

\ Defines name ( i -- addr ), the address of cell i of n cells that start at 0.
: shelf ( n "name" -- )
  create cells  here over erase  allot
  does> ( i -- addr ) swap cells + ;
