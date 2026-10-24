\ Classify a positive integer by its aliquot sum (the sum of its divisors other than itself)
\ as one of the constants below. Throw -24 (invalid numeric argument) unless n is positive,
\ since classification is only possible for positive integers:
\   28 classify  ( -- perfect )
0 constant deficient
1 constant perfect
2 constant abundant

: classify ( n -- classification )
  true abort" implement me" ;
