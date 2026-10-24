\ The distance in km of ly light years, as a double.
: light-years>km ( ly -- d )
  9460730472581 m* ;   \ km in a light year

\ A distance in km as a distance in metres.
: km>metres ( d-km -- d-m )
  1000 1 m*/ ;

\ The distance there and back.
: round-trip ( d -- d' )
  2dup d+ ;

\ True when d1 is strictly greater than d2.
: farther? ( d1 d2 -- flag )
  2swap d< ;

\ Whole days to cover d-km at km-per-day.
: travel-days ( d-km km-per-day -- days )
  um/mod nip ;
