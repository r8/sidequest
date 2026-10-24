\ Minutes to boil water for the cups: 3 plus one per cup, or 0 for none.
: kettle-minutes ( cups -- minutes )
  dup if 3 + then ;

\ Minutes to steep: 2 under 3 grams, 3 up to 6 grams, 4 above.
: steep-minutes ( grams -- minutes )
  dup 3 < if drop 2 exit then
  6 > if 4 else 3 then ;

\ The serving temperature: at most 70, and reheated to 85 below 55.
: serve-temp ( celsius -- celsius )
  dup 70 > if drop 70 exit then
  dup 55 < if drop 85 then ;

\ 250 pence a cup, 10% off orders of 10 cups or more.
: bill ( cups -- pence )
  dup 250 *  swap 10 >= if 9 10 */ then ;
