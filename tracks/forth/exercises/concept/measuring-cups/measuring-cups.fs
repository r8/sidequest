\ Defines name ( n -- ml ), converting n of a unit of ml millilitres.
: unit ( ml "name" -- )
  true abort" implement me" ;

\ Defines name ( -- n ), leaving 1, 2, 3, … on successive uses.
: counter ( "name" -- )
  true abort" implement me" ;

\ Sets the counter xt back to the start, so its next use leaves 1.
: reset-counter ( xt -- )
  true abort" implement me" ;

\ Defines name ( i -- addr ), the address of cell i of n cells that start at 0.
: shelf ( n "name" -- )
  true abort" implement me" ;
