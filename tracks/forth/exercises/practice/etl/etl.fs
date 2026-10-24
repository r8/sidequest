\ The legacy data maps each score to its upper-case letters. transform takes n pairs, each a string of
\ letters and their score, followed by n, and builds the new map from lowercase letter to score:
\   s" AE" 1  s" DG" 2  2 transform  [char] d score  ( -- 2 )
\ score gives 0 for a letter the legacy data did not mention; #letters is the number of letters in the
\ new map. The map stays until the next transform.
: transform ( c-addr1 u1 score1 ... c-addrn un scoren n -- )
  true abort" implement me" ;

: score ( char -- n )
  true abort" implement me" ;

: #letters ( -- n )
  true abort" implement me" ;
