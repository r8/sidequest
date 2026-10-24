\ The first character of a name.
: initial ( c-addr u -- c )
  drop c@ ;

\ How many times the character c appears in the name.
: count-letter ( c-addr u c -- n )
  0 2swap bounds ?do  over i c@ = if 1+ then  loop nip ;

\ True if the two names are the same text.
: same-name? ( c-addr1 u1 c-addr2 u2 -- flag )
  compare 0= ;

\ True if the string is not empty and starts with a space.
: blank-start? ( c-addr u -- c-addr u flag )
  dup if over c@ bl = else false then ;

\ The name without leading or trailing spaces.
: trim ( c-addr u -- c-addr2 u2 )
  -trailing  begin blank-start? while 1 /string repeat ;

\ The part before the first space, or the whole name.
: first-name ( c-addr u -- c-addr u2 )
  2dup bounds ?do  i c@ bl = if drop i over - leave then  loop ;

\ The part after the first space; empty if there is none.
: surname ( c-addr u -- c-addr2 u2 )
  2dup first-name nip 1+ over min /string ;
