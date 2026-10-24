require ../lib/test.fs
require ../pascals-triangle.fs

\ The rows are flattened into one array: 3 rows are 1  1 1  1 2 1.

create no-rows
test" zero rows"  0 pascals-triangle no-rows 0 assert-cells= ;test

create one-row 1 ,
test" single row"  1 pascals-triangle one-row 1 assert-cells= ;test

create two-rows 1 ,  1 , 1 ,
test" two rows"  2 pascals-triangle two-rows 3 assert-cells= ;test

create three-rows 1 ,  1 , 1 ,  1 , 2 , 1 ,
test" three rows"  3 pascals-triangle three-rows 6 assert-cells= ;test

create four-rows 1 ,  1 , 1 ,  1 , 2 , 1 ,  1 , 3 , 3 , 1 ,
test" four rows"  4 pascals-triangle four-rows 10 assert-cells= ;test

create five-rows 1 ,  1 , 1 ,  1 , 2 , 1 ,  1 , 3 , 3 , 1 ,  1 , 4 , 6 , 4 , 1 ,
test" five rows"  5 pascals-triangle five-rows 15 assert-cells= ;test

create six-rows 1 ,  1 , 1 ,  1 , 2 , 1 ,  1 , 3 , 3 , 1 ,  1 , 4 , 6 , 4 , 1 ,  1 , 5 , 10 , 10 , 5 , 1 ,
test" six rows"  6 pascals-triangle six-rows 21 assert-cells= ;test

create ten-rows
  1 ,
  1 , 1 ,
  1 , 2 , 1 ,
  1 , 3 , 3 , 1 ,
  1 , 4 , 6 , 4 , 1 ,
  1 , 5 , 10 , 10 , 5 , 1 ,
  1 , 6 , 15 , 20 , 15 , 6 , 1 ,
  1 , 7 , 21 , 35 , 35 , 21 , 7 , 1 ,
  1 , 8 , 28 , 56 , 70 , 56 , 28 , 8 , 1 ,
  1 , 9 , 36 , 84 , 126 , 126 , 84 , 36 , 9 , 1 ,
test" ten rows"  10 pascals-triangle ten-rows 55 assert-cells= ;test

end-tests
