\ Score a dart landing at (x, y), the coordinates on the float stack: 10 points inside the
\ inner circle (radius 1), 5 inside the middle one (radius 5), 1 inside the outer one
\ (radius 10), 0 outside. A dart on a circle's edge counts as inside it:
\   0e 10e score  ( -- 1 )
: squared-distance ( F: x y -- dd ) fdup f* fswap fdup f* f+ ;

: inside? ( radius -- flag ) ( F: dd -- dd ) fdup dup * s>f f<= ;

: score ( F: x y -- ) ( -- points )
  squared-distance
  1 inside? if 10 else  5 inside? if 5 else  10 inside? if 1 else 0 then then then
  fdrop ;
