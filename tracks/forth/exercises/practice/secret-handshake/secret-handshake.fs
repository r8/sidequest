\ commands turns a number from 1 to 31 into the handshake: its actions joined by a comma and a space,
\   19 commands  ( -- c-addr u )  \ "double blink, wink"
\ and an empty string when there are none. The string lives in a buffer of the solution, valid until
\ the next call.
: commands ( n -- c-addr u )
  true abort" implement me" ;
