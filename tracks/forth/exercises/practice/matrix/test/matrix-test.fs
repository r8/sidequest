require ../lib/test.fs
require ../matrix.fs

create just-one 1 ,
test" extract row from one number matrix"  s" 1" 1 row just-one 1 assert-cells= ;test

create three-four 3 , 4 ,
test" can extract row"  s\" 1 2\n3 4" 2 row three-four 2 assert-cells= ;test

create ten-twenty 10 , 20 ,
test" extract row where numbers have different widths"  s\" 1 2\n10 20" 2 row ten-twenty 2 assert-cells= ;test

create eight-seven-six 8 , 7 , 6 ,
test" can extract row from non-square matrix with no corresponding column"
  s\" 1 2 3\n4 5 6\n7 8 9\n8 7 6" 4 row eight-seven-six 3 assert-cells= ;test

test" extract column from one number matrix"  s" 1" 1 column just-one 1 assert-cells= ;test

create three-six-nine 3 , 6 , 9 ,
test" can extract column"  s\" 1 2 3\n4 5 6\n7 8 9" 3 column three-six-nine 3 assert-cells= ;test

create four-eight-six 4 , 8 , 6 ,
test" can extract column from non-square matrix with no corresponding row"
  s\" 1 2 3 4\n5 6 7 8\n9 8 7 6" 4 column four-eight-six 3 assert-cells= ;test

create wide-column 1903 , 3 , 4 ,
test" extract column where numbers have different widths"
  s\" 89 1903 3\n18 3 1\n9 4 800" 2 column wide-column 3 assert-cells= ;test

\ Not in the canonical data: a 20-by-20 matrix, more numbers than any fixed-size table a solution
\ might reach for. Each row is 0 1 … 9 0 1 … 9.
create big-matrix 799 chars allot  big-matrix 799 bl fill
: fill-big-matrix ( -- )
  20 0 do
    20 0 do  i 10 mod [char] 0 +  big-matrix j 40 * i 2* + chars + c!  loop
    i 19 < if  10 big-matrix i 40 * 39 + chars + c!  then
  loop ;
fill-big-matrix
create digit-row 20 cells allot
: fill-digit-row ( -- ) 20 0 do  i 10 mod digit-row i cells + !  loop ;  fill-digit-row
create twos 20 cells allot
: fill-twos ( -- ) 20 0 do  2 twos i cells + !  loop ;  fill-twos
test" extract a row from a large matrix"  big-matrix 799 20 row digit-row 20 assert-cells= ;test
test" extract a column from a large matrix"  big-matrix 799 13 column twos 20 assert-cells= ;test

end-tests
