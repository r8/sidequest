\ The items are a flat array of weight/value pairs, two cells per item:
\   create items  5 , 10 ,  4 , 40 ,     \ two items: weight 5 value 10, weight 4 value 40
\   items 2 10 maximum-value             \ n is the number of items, then the weight limit
\ maximum-value returns the largest total value of items, each taken at most once, whose
\ weights add up to no more than the limit.
\ Throw -24 (invalid numeric argument) for a negative weight limit.

: maximum-value ( items n max-weight -- value )
  true abort" implement me" ;
