\ Each word takes the three side lengths on the float stack and returns a flag. Sides must all
\ be positive and satisfy the triangle inequality (a + b >= c for every side), or the flag is false:
\   3e 4e 4e isosceles?  ( -- true )
: equilateral? ( F: a b c -- ) ( -- flag )
  true abort" implement me" ;

: isosceles? ( F: a b c -- ) ( -- flag )
  true abort" implement me" ;

: scalene? ( F: a b c -- ) ( -- flag )
  true abort" implement me" ;
