: divisible? ( n d -- flag ) mod 0= ;

: leap-year? ( year -- flag )
  dup 4 divisible?  over 100 divisible? 0= and  swap 400 divisible? or ;
