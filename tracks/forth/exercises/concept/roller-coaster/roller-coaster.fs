\ True when the rider is at least 120 cm tall.
: tall-enough? ( cm -- flag )
  true abort" implement me" ;

\ True when the rider is from 120 cm through 195 cm tall.
: fits-the-seat? ( cm -- flag )
  true abort" implement me" ;

\ True when the rider fits the seat and is at least 8.
: may-ride? ( cm age -- flag )
  true abort" implement me" ;

\ True when at least one of the two riders is 16 or older.
: ride-together? ( age1 age2 -- flag )
  true abort" implement me" ;

\ The number of true flags among three well-formed flags.
: riders ( flag1 flag2 flag3 -- n )
  true abort" implement me" ;
