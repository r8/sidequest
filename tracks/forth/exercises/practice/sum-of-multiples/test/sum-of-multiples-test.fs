require ../lib/test.fs
require ../sum-of-multiples.fs

create factors-1 3 , 5 ,
test" no multiples within limit"  factors-1 2 1 sum-of-multiples 0 assert= ;test
create factors-2 3 , 5 ,
test" one factor has multiples within limit"  factors-2 2 4 sum-of-multiples 3 assert= ;test
create factors-3 3 ,
test" more than one multiple within limit"  factors-3 1 7 sum-of-multiples 9 assert= ;test
create factors-4 3 , 5 ,
test" more than one factor with multiples within limit"  factors-4 2 10 sum-of-multiples 23 assert= ;test
create factors-5 3 , 5 ,
test" each multiple is only counted once"  factors-5 2 100 sum-of-multiples 2318 assert= ;test
create factors-6 3 , 5 ,
test" a much larger limit"  factors-6 2 1000 sum-of-multiples 233168 assert= ;test
create factors-7 7 , 13 , 17 ,
test" three factors"  factors-7 3 20 sum-of-multiples 51 assert= ;test
create factors-8 4 , 6 ,
test" factors not relatively prime"  factors-8 2 15 sum-of-multiples 30 assert= ;test
create factors-9 5 , 6 , 8 ,
test" some pairs of factors relatively prime and some not"  factors-9 3 150 sum-of-multiples 4419 assert= ;test
create factors-10 5 , 25 ,
test" one factor is a multiple of another"  factors-10 2 51 sum-of-multiples 275 assert= ;test
create factors-11 43 , 47 ,
test" much larger factors"  factors-11 2 10000 sum-of-multiples 2203160 assert= ;test
create factors-12 1 ,
test" all numbers are multiples of 1"  factors-12 1 100 sum-of-multiples 4950 assert= ;test
create factors-13
test" no factors means an empty sum"  factors-13 0 10000 sum-of-multiples 0 assert= ;test
create factors-14 0 ,
test" the only multiple of 0 is 0"  factors-14 1 1 sum-of-multiples 0 assert= ;test
create factors-15 3 , 0 ,
test" the factor 0 does not affect the sum of multiples of other factors"  factors-15 2 4 sum-of-multiples 3 assert= ;test
create factors-16 2 , 3 , 5 , 7 , 11 ,
test" solutions using include-exclude must extend to cardinality greater than 3"  factors-16 5 10000 sum-of-multiples 39614537 assert= ;test

\ Not in the canonical data: level 0, below which there are no numbers at all.
test" no numbers below level 0"  factors-16 5 0 sum-of-multiples 0 assert= ;test

end-tests
