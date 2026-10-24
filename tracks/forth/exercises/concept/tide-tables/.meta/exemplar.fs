\ A day's readings are an array of n cells at table, the first reading first.

\ The reading at index i.
: tide-at ( table i -- level )
  cells + @ ;

\ The highest of n readings (n is at least 1).
: highest ( table n -- level )
  over @ -rot  cells bounds ?do  i @ max  cell +loop ;

\ The sum of n readings.
: total ( table n -- sum )
  0 -rot  cells bounds ?do  i @ +  cell +loop ;

\ The average of n readings, rounded down (n is at least 1).
: average-level ( table n -- level )
  tuck total swap / ;

\ The index of the first reading below level, or -1.
: first-below ( table n level -- i )
  swap 0 ?do
    over i tide-at over < if 2drop i unloop exit then
  loop 2drop -1 ;

\ Adds amount to every reading, in place.
: raise-all ( table n amount -- )
  -rot  cells bounds ?do  dup i +!  cell +loop drop ;
