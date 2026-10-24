require ../lib/test.fs
require ../gigasecond.fs

\ Compares two moments field by field, seconds first.
create expected-moment 6 cells allot
: assert-moment= ( y m d h min s  y' m' d' h' min' s' -- )
  0 5 do expected-moment i cells + ! -1 +loop
  0 5 do expected-moment i cells + @ assert= -1 +loop ;

test" date only specification of time"  2011 4 25 0 0 0 add  2043 1 1 1 46 40 assert-moment= ;test
test" second test for date only specification of time"  1977 6 13 0 0 0 add  2009 2 19 1 46 40 assert-moment= ;test
test" third test for date only specification of time"  1959 7 19 0 0 0 add  1991 3 27 1 46 40 assert-moment= ;test
test" full time specified"  2015 1 24 22 0 0 add  2046 10 2 23 46 40 assert-moment= ;test
test" full time with day roll-over"  2015 1 24 23 59 59 add  2046 10 3 1 46 39 assert-moment= ;test

end-tests
