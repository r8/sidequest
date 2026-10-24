\ Every Pythagorean triplet a < b < c with a*a + b*b = c*c and a + b + c = sum, ordered by a,
\ as a flat array of cells holding a b c for each triplet in turn; n counts cells (three per
\ triplet). The array is in a buffer the solution owns, valid until the next call:
\   90 triplets-with-sum  ( -- addr 6 )  \ 9 40 41  15 36 39
: triplets-with-sum ( sum -- addr n )
  true abort" implement me" ;
