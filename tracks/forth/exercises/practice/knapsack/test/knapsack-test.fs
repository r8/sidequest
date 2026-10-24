require ../lib/test.fs
require ../knapsack.fs

\ Items are weight/value pairs.

create no-items
test" no items"  no-items 0 100 maximum-value 0 assert= ;test

create too-heavy 100 , 1 ,
test" one item, too heavy"  too-heavy 1 10 maximum-value 0 assert= ;test

create not-greedy-by-weight  2 , 5 ,  2 , 5 ,  2 , 5 ,  2 , 5 ,  10 , 21 ,
test" five items (cannot be greedy by weight)"  not-greedy-by-weight 5 10 maximum-value 21 assert= ;test

create not-greedy-by-value  2 , 20 ,  2 , 20 ,  2 , 20 ,  2 , 20 ,  10 , 50 ,
test" five items (cannot be greedy by value)"  not-greedy-by-value 5 10 maximum-value 80 assert= ;test

create example-items  5 , 10 ,  4 , 40 ,  6 , 30 ,  4 , 50 ,
test" example knapsack"  example-items 4 10 maximum-value 90 assert= ;test

create eight-items
  25 , 350 ,  35 , 400 ,  45 , 450 ,  5 , 20 ,  25 , 70 ,  3 , 8 ,  2 , 5 ,  2 , 5 ,
test" 8 items"  eight-items 8 104 maximum-value 900 assert= ;test

create fifteen-items
  70 , 135 ,  73 , 139 ,  77 , 149 ,  80 , 150 ,  82 , 156 ,
  87 , 163 ,  90 , 173 ,  94 , 184 ,  98 , 192 ,  106 , 201 ,
  110 , 210 ,  113 , 214 ,  115 , 221 ,  118 , 229 ,  120 , 240 ,
test" 15 items"  fifteen-items 15 750 maximum-value 1458 assert= ;test

end-tests
