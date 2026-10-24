\ The legacy data maps each score to its upper-case letters. transform takes n pairs, each a string of
\ letters and their score, followed by n, and builds the new map from lowercase letter to score:
\   s" AE" 1  s" DG" 2  2 transform  [char] d score  ( -- 2 )
\ score gives 0 for a letter the legacy data did not mention; #letters is the number of letters in the
\ new map. The map stays until the next transform.

create scores 26 cells allot

: lower ( char -- char' ) dup [char] A [char] Z 1+ within bl and + ;
: letter? ( char -- flag ) [char] a [char] z 1+ within ;
: slot ( char -- addr ) [char] a - cells scores + ;

: assign ( c-addr u score -- ) -rot bounds ?do  dup i c@ lower slot !  loop drop ;

: transform ( c-addr1 u1 score1 ... c-addrn un scoren n -- )
  scores 26 cells erase  0 ?do assign loop ;

: score ( char -- n ) dup letter? if slot @ else drop 0 then ;

: #letters ( -- n ) 0  26 0 do scores i cells + @ 0<> - loop ;
