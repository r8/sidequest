\ modifier gives the ability modifier of a score, and ability rolls one random score: four six-sided
\ dice, keeping the three highest. A character is a structure of /character address units that the
\ caller allots; roll-character fills it with six abilities and the hitpoints, and the words from
\ strength to hitpoints read them back:
\   create hero /character allot  hero roll-character  hero strength  ( -- n )
\ random.fs provides random ( n -- 0..n-1 ).
require random.fs

7 cells constant /character

: modifier ( score -- n ) 10 - 2/ ;  \ 2/ shifts, so it rounds down

: d6 ( -- n ) 6 random 1+ ;

\ The sum of four dice minus the lowest.
: ability ( -- n ) 0 6  4 0 do d6 tuck min >r + r> loop - ;

\ Each ability is a cell of the character, at the offset n.
: stat ( n "name" -- ) create cells , does> ( character -- n ) @ + @ ;
0 stat strength
1 stat dexterity
2 stat constitution
3 stat intelligence
4 stat wisdom
5 stat charisma
6 stat hitpoints

: roll-character ( character -- )
  6 0 do ability over i cells + ! loop
  dup constitution modifier 10 +  swap 6 cells + ! ;
