\ The number of ways to line up n dolls.
: arrangements ( n -- ways )
  dup 2 < if drop 1 exit then
  dup 1- recurse * ;

\ The number of dolls in a set whose largest doll is height cm tall.
: layers ( height -- dolls )
  dup 1 < if drop 0 exit then
  2 3 */ recurse 1+ ;

\ The side of the largest square that divides a width x height board exactly.
: largest-square ( width height -- side )
  ?dup 0= if exit then
  tuck mod recurse ;

\ The number of dolls in a set where every doll holds branching dolls, depth levels down.
: family-size ( branching depth -- dolls )
  dup 1 < if 2drop 1 exit then
  over swap 1- recurse * 1+ ;
