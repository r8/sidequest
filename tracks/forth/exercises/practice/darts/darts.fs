\ Score a dart landing at (x, y), the coordinates on the float stack: 10 points inside the
\ inner circle (radius 1), 5 inside the middle one (radius 5), 1 inside the outer one
\ (radius 10), 0 outside. A dart on a circle's edge counts as inside it:
\   0e 10e score  ( -- 1 )
: score ( F: x y -- ) ( -- points )
  true abort" implement me" ;
