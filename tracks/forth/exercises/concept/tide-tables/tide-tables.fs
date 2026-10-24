\ A day's readings are an array of n cells at table, the first reading first.

\ The reading at index i.
: tide-at ( table i -- level )
  true abort" implement me" ;

\ The highest of n readings (n is at least 1).
: highest ( table n -- level )
  true abort" implement me" ;

\ The average of n readings, rounded down (n is at least 1).
: average-level ( table n -- level )
  true abort" implement me" ;

\ The index of the first reading below level, or -1.
: first-below ( table n level -- i )
  true abort" implement me" ;

\ Adds amount to every reading, in place.
: raise-all ( table n amount -- )
  true abort" implement me" ;
