\ The number with only switch n's bit set.
: switch-mask ( n -- mask )
  true abort" implement me" ;

\ True if switch n is on.
: switch-on? ( settings n -- flag )
  true abort" implement me" ;

\ The settings with switch n on.
: turn-on ( settings n -- settings' )
  true abort" implement me" ;

\ The settings with switch n off.
: turn-off ( settings n -- settings' )
  true abort" implement me" ;

\ The settings with switch n in the opposite position.
: flip ( settings n -- settings' )
  true abort" implement me" ;

\ How many of the eight switches are on.
: switches-on ( settings -- count )
  true abort" implement me" ;
