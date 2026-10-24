\ Classify a positive integer by its aliquot sum (the sum of its divisors other than itself)
\ as one of the constants below. Throw -24 (invalid numeric argument) unless n is positive,
\ since classification is only possible for positive integers:
\   28 classify  ( -- perfect )
0 constant deficient
1 constant perfect
2 constant abundant

\ If i divides n, add both i and n/i (once when they are equal).
: +divisor-pair ( sum n i -- sum' n )
  2dup mod if drop exit then
  2dup / 2dup = if drop else + then  rot + swap ;

\ 1 divides everything above 1; the other divisors come in pairs i, n/i with i*i <= n.
: aliquot-sum ( n -- sum )
  dup 1 = if drop 0 exit then
  1 swap 2 begin ( sum n i ) 2dup dup * >= while  dup >r +divisor-pair r> 1+  repeat 2drop ;

: classify ( n -- classification )
  dup 1 < if -24 throw then
  dup aliquot-sum 2dup = if 2drop perfect exit then
  < if abundant else deficient then ;
