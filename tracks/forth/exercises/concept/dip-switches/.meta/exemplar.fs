\ The number with only switch n's bit set.
: switch-mask ( n -- mask )
  1 swap lshift ;

\ True if switch n is on.
: switch-on? ( settings n -- flag )
  switch-mask and 0<> ;

\ The settings with switch n on.
: turn-on ( settings n -- settings' )
  switch-mask or ;

\ The settings with switch n off.
: turn-off ( settings n -- settings' )
  switch-mask invert and ;

\ The settings with switch n in the opposite position.
: flip ( settings n -- settings' )
  switch-mask xor ;

\ How many of the eight switches are on.
: switches-on ( settings -- count )
  0 swap  8 0 do  dup i switch-on? if swap 1+ swap then  loop drop ;
