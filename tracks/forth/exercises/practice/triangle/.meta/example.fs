\ Each word takes the three side lengths on the float stack and returns a flag. Sides must all
\ be positive and satisfy the triangle inequality (a + b >= c for every side), or the flag is false:
\   3e 4e 4e isosceles?  ( -- true )
fvariable side-a  fvariable side-b  fvariable side-c

: sides! ( F: a b c -- ) side-c f! side-b f! side-a f! ;

: positive? ( -- flag ) side-a f@ f0> side-b f@ f0> and side-c f@ f0> and ;

\ The sum of two sides is at least the third.
: reaches? ( F: x y z -- ) ( -- flag ) frot frot f+ f<= ;

: inequality? ( -- flag )
  side-a f@ side-b f@ side-c f@ reaches?
  side-b f@ side-c f@ side-a f@ reaches? and
  side-a f@ side-c f@ side-b f@ reaches? and ;

: triangle? ( -- flag ) positive? inequality? and ;

: f=? ( F: x y -- ) ( -- 0|1 ) f= 1 and ;

: #equal-pairs ( -- n )
  side-a f@ side-b f@ f=?  side-b f@ side-c f@ f=? +  side-a f@ side-c f@ f=? + ;

: equilateral? ( F: a b c -- ) ( -- flag ) sides! triangle? #equal-pairs 3 = and ;

: isosceles? ( F: a b c -- ) ( -- flag ) sides! triangle? #equal-pairs 0> and ;

: scalene? ( F: a b c -- ) ( -- flag ) sides! triangle? #equal-pairs 0= and ;
