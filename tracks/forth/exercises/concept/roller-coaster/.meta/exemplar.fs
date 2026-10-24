\ True when the rider is at least 120 cm tall.
: tall-enough? ( cm -- flag )
  120 >= ;

\ True when the rider is from 120 cm through 195 cm tall.
: fits-the-seat? ( cm -- flag )
  120 196 within ;

\ True when the rider fits the seat and is at least 8.
: may-ride? ( cm age -- flag )
  8 >= swap fits-the-seat? and ;

\ True when at least one of the two riders is 16 or older.
: ride-together? ( age1 age2 -- flag )
  max 16 >= ;

\ The number of true flags among three well-formed flags.
: riders ( flag1 flag2 flag3 -- n )
  + + negate ;
