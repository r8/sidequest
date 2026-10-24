\ The first character of a name.
: initial ( c-addr u -- c )
  true abort" implement me" ;

\ How many times the character c appears in the name.
: count-letter ( c-addr u c -- n )
  true abort" implement me" ;

\ True if the two names are the same text.
: same-name? ( c-addr1 u1 c-addr2 u2 -- flag )
  true abort" implement me" ;

\ The name without leading or trailing spaces.
: trim ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;

\ The part before the first space, or the whole name.
: first-name ( c-addr u -- c-addr u2 )
  true abort" implement me" ;

\ The part after the first space; empty if there is none.
: surname ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
