require ../lib/test.fs
require ../spiral-matrix.fs

\ The matrix is one flat array, row after row.

create empty-spiral
test" empty spiral"  0 spiral-matrix empty-spiral 0 assert-cells= ;test

create spiral-1 1 ,
test" trivial spiral"  1 spiral-matrix spiral-1 1 assert-cells= ;test

create spiral-2
  1 , 2 ,
  4 , 3 ,
test" spiral of size 2"  2 spiral-matrix spiral-2 4 assert-cells= ;test

create spiral-3
  1 , 2 , 3 ,
  8 , 9 , 4 ,
  7 , 6 , 5 ,
test" spiral of size 3"  3 spiral-matrix spiral-3 9 assert-cells= ;test

create spiral-4
   1 ,  2 ,  3 , 4 ,
  12 , 13 , 14 , 5 ,
  11 , 16 , 15 , 6 ,
  10 ,  9 ,  8 , 7 ,
test" spiral of size 4"  4 spiral-matrix spiral-4 16 assert-cells= ;test

create spiral-5
   1 ,  2 ,  3 ,  4 , 5 ,
  16 , 17 , 18 , 19 , 6 ,
  15 , 24 , 25 , 20 , 7 ,
  14 , 23 , 22 , 21 , 8 ,
  13 , 12 , 11 , 10 , 9 ,
test" spiral of size 5"  5 spiral-matrix spiral-5 25 assert-cells= ;test

end-tests
