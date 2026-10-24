\ The machine's own error codes, and the money inserted so far.
1 constant sold-out
2 constant not-enough-money
variable credit

\ The change for an item; throws not-enough-money when paid is less than price.
: change ( price paid -- change )
  true abort" implement me" ;

\ One item fewer; throws sold-out when the slot is empty.
: take-one ( stock -- stock' )
  true abort" implement me" ;

\ A slot number from 1 to 12 as it is; throws -24 for any other.
: check-slot ( n -- n )
  true abort" implement me" ;

\ The change, or all the money paid when it is not enough.
: change-or-refund ( price paid -- coins )
  true abort" implement me" ;

\ Runs xt; leaves 0, or the code it throws after setting credit to 0.
: guarded ( xt -- code )
  true abort" implement me" ;
