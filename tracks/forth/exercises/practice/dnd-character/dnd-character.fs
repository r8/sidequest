\ modifier gives the ability modifier of a score, and ability rolls one random score: four six-sided
\ dice, keeping the three highest. A character is a structure of /character address units that the
\ caller allots; roll-character fills it with six abilities and the hitpoints, and the words from
\ strength to hitpoints read them back:
\   create hero /character allot  hero roll-character  hero strength  ( -- n )
\ random.fs provides random ( n -- 0..n-1 ).
require random.fs

7 cells constant /character  \ change it to suit your layout

: modifier ( score -- n )
  true abort" implement me" ;

: ability ( -- n )
  true abort" implement me" ;

: roll-character ( character -- )
  true abort" implement me" ;

: strength ( character -- n )
  true abort" implement me" ;

: dexterity ( character -- n )
  true abort" implement me" ;

: constitution ( character -- n )
  true abort" implement me" ;

: intelligence ( character -- n )
  true abort" implement me" ;

: wisdom ( character -- n )
  true abort" implement me" ;

: charisma ( character -- n )
  true abort" implement me" ;

: hitpoints ( character -- n )
  true abort" implement me" ;
