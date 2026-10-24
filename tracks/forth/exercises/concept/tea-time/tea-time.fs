\ Minutes to boil water for the cups: 3 plus one per cup, or 0 for none.
: kettle-minutes ( cups -- minutes )
  true abort" implement me" ;

\ Minutes to steep: 2 under 3 grams, 3 up to 6 grams, 4 above.
: steep-minutes ( grams -- minutes )
  true abort" implement me" ;

\ The serving temperature: at most 70, and reheated to 85 below 55.
: serve-temp ( celsius -- celsius )
  true abort" implement me" ;

\ 250 pence a cup, 10% off orders of 10 cups or more.
: bill ( cups -- pence )
  true abort" implement me" ;
