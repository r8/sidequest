\ The items are a flat array of weight/value pairs, two cells per item:
\   create items  5 , 10 ,  4 , 40 ,     \ two items: weight 5 value 10, weight 4 value 40
\   items 2 10 maximum-value             \ n is the number of items, then the weight limit
\ maximum-value returns the largest total value of items, each taken at most once, whose
\ weights add up to no more than the limit.
\ Throw -24 (invalid numeric argument) for a negative weight limit.

\ best[w] is the most value that fits in weight w using the items considered so far; the table
\ is allocated for each call.
variable best
variable limit

: best@ ( w -- v ) cells best @ + @ ;
: best! ( v w -- ) cells best @ + ! ;

\ Improves best[w] with the item, if taking it beats leaving it out.
: consider ( value weight w -- )
  tuck swap - best@ rot +  over best@ max  swap best! ;

\ Going from the heaviest w down lets each item count only once.
: add-item ( item -- )
  dup cell+ @ swap @  ( value weight )
  dup limit @ > if 2drop exit then
  dup limit @ do 2dup i consider -1 +loop 2drop ;

: maximum-value ( items n max-weight -- value )
  dup 0< if -24 throw then
  dup limit !  1+ cells dup allocate throw  dup best !  swap erase
  2 cells * bounds ?do i add-item 2 cells +loop
  limit @ best@  best @ free throw ;
