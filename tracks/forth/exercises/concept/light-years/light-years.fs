\ The distance in km of ly light years, as a double.
: light-years>km ( ly -- d )
  true abort" implement me" ;

\ A distance in km as a distance in metres.
: km>metres ( d-km -- d-m )
  true abort" implement me" ;

\ The distance there and back.
: round-trip ( d -- d' )
  true abort" implement me" ;

\ True when d1 is strictly greater than d2.
: farther? ( d1 d2 -- flag )
  true abort" implement me" ;

\ Whole days to cover d-km at km-per-day.
: travel-days ( d-km km-per-day -- days )
  true abort" implement me" ;
