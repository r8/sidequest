\ Every Pythagorean triplet a < b < c with a*a + b*b = c*c and a + b + c = sum, ordered by a,
\ as a flat array of cells holding a b c for each triplet in turn; n counts cells (three per
\ triplet). The array is in a buffer the solution owns, valid until the next call:
\   90 triplets-with-sum  ( -- addr 6 )  \ 9 40 41  15 36 39
create triplets 3000 cells allot
variable #triplets

: cell>triplets ( n -- ) triplets #triplets @ cells + !  1 #triplets +! ;

: triplet, ( a b c -- ) rot cell>triplets swap cell>triplets cell>triplets ;

\ Substituting c = sum - a - b into a*a + b*b = c*c gives b = sum(sum - 2a) / 2(sum - a);
\ a triplet exists for a when that division leaves no remainder.
: leg-b ( sum a -- rem b ) 2dup 2* - 2 pick * -rot - 2* /mod ;

: hypotenuse ( sum a b -- a b c ) rot 2 pick - over - ;

: try-a ( sum a -- )
  2dup leg-b swap if 2drop drop exit then  ( sum a b )
  2dup < 0= if 2drop drop exit then
  hypotenuse triplet, ;

: triplets-with-sum ( sum -- addr n )
  0 #triplets !
  dup 3 / 1 max 1 ?do dup i try-a loop drop
  triplets #triplets @ ;
