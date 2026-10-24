\ commands turns a number from 1 to 31 into the handshake: its actions joined by a comma and a space,
\   19 commands  ( -- c-addr u )  \ "double blink, wink"
\ and an empty string when there are none. The string lives in a buffer of the solution, valid until
\ the next call.

create handshake 64 chars allot  \ a counted string

: action ( i -- c-addr u )
  case
    0 of s" wink" endof
    1 of s" double blink" endof
    2 of s" close your eyes" endof
    3 of s" jump" endof
  endcase ;

: +action ( i -- )
  handshake c@ if s" , " handshake +place then  action handshake +place ;

: bit? ( n i -- flag ) 1 swap lshift and 0<> ;
: perform ( n i -- n ) 2dup bit? if dup +action then drop ;

: commands ( n -- c-addr u )
  0 handshake c!
  dup 4 bit? if 0 3 do i perform -1 +loop else 4 0 do i perform loop then
  drop handshake count ;
