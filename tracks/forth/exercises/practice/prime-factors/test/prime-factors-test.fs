require ../lib/test.fs
require ../prime-factors.fs

create factors-of-1
test" no factors"  1 prime-factors factors-of-1 0 assert-cells= ;test
create factors-of-2 2 ,
test" prime number"  2 prime-factors factors-of-2 1 assert-cells= ;test
create factors-of-3 3 ,
test" another prime number"  3 prime-factors factors-of-3 1 assert-cells= ;test
create factors-of-9 3 , 3 ,
test" square of a prime"  9 prime-factors factors-of-9 2 assert-cells= ;test
create factors-of-4 2 , 2 ,
test" product of first prime"  4 prime-factors factors-of-4 2 assert-cells= ;test
create factors-of-8 2 , 2 , 2 ,
test" cube of a prime"  8 prime-factors factors-of-8 3 assert-cells= ;test
create factors-of-27 3 , 3 , 3 ,
test" product of second prime"  27 prime-factors factors-of-27 3 assert-cells= ;test
create factors-of-625 5 , 5 , 5 , 5 ,
test" product of third prime"  625 prime-factors factors-of-625 4 assert-cells= ;test
create factors-of-6 2 , 3 ,
test" product of first and second prime"  6 prime-factors factors-of-6 2 assert-cells= ;test
create factors-of-12 2 , 2 , 3 ,
test" product of primes and non-primes"  12 prime-factors factors-of-12 3 assert-cells= ;test
create factors-of-901255 5 , 17 , 23 , 461 ,
test" product of primes"  901255 prime-factors factors-of-901255 4 assert-cells= ;test
create factors-of-93819012551 11 , 9539 , 894119 ,
test" factors include a large prime"  93819012551 prime-factors factors-of-93819012551 3 assert-cells= ;test

\ Not in the canonical data: a u with its top bit set, the highest power of 2 in a cell.
8 cells 1- constant top-bit
create top-bit-twos top-bit cells allot
: fill-twos ( -- ) top-bit 0 do  2 top-bit-twos i cells + !  loop ;  fill-twos
test" the highest power of 2 in a cell"  1 top-bit lshift prime-factors top-bit-twos top-bit assert-cells= ;test

end-tests
