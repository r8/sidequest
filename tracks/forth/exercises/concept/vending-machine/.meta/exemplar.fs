\ The machine's own error codes, and the money inserted so far.
1 constant sold-out
2 constant not-enough-money
variable credit

\ The change for an item; throws not-enough-money when paid is less than price.
: change ( price paid -- change )
  2dup > if not-enough-money throw then  swap - ;

\ One item fewer; throws sold-out when the slot is empty.
: take-one ( stock -- stock' )
  dup 0= if sold-out throw then  1- ;

\ A slot number from 1 to 12 as it is; throws -24 for any other.
: check-slot ( n -- n )
  dup 1 13 within 0= if -24 throw then ;

\ The change, or all the money paid when it is not enough. The amount paid waits on the return
\ stack, which catch restores, because the items catch leaves after a throw are only placeholders.
: change-or-refund ( price paid -- coins )
  dup >r  ['] change catch
  ?dup if
    dup not-enough-money <> if throw then
    drop 2drop r> exit
  then
  r> drop ;

\ Runs xt; leaves 0, or the code it throws after setting credit to 0.
: guarded ( xt -- code )
  catch  dup if 0 credit ! then ;
