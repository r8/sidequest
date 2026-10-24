require ../lib/test.fs
require ../flatten-array.fs

\ Nested arrays are written with the markers <[ and ]>, and null for null (see flatten-array.fs).

create nothing
test" empty"  nothing 0 flatten nothing 0 assert-cells= ;test

create zero-one-two 0 , 1 , 2 ,
test" no nesting"  zero-one-two 3 flatten zero-one-two 3 assert-cells= ;test

create nested-empty <[ , <[ , ]> , ]> ,
test" flattens a nested array"  nested-empty 4 flatten nothing 0 assert-cells= ;test

create integers-only 1 , <[ , 2 , 3 , 4 , 5 , 6 , 7 , ]> , 8 ,
create one-to-eight 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 ,
test" flattens array with just integers present"  integers-only 10 flatten one-to-eight 8 assert-cells= ;test

create five-levels 0 , 2 , <[ , <[ , 2 , 3 , ]> , 8 , 100 , 4 , <[ , <[ , <[ , 50 , ]> , ]> , ]> , ]> , -2 ,
create five-levels-flat 0 , 2 , 2 , 3 , 8 , 100 , 4 , 50 , -2 ,
test" 5 level nesting"  five-levels 19 flatten five-levels-flat 9 assert-cells= ;test

create six-levels 1 , <[ , 2 , <[ , <[ , 3 , ]> , ]> , <[ , 4 , <[ , <[ , 5 , ]> , ]> , ]> , 6 , 7 , ]> , 8 ,
test" 6 level nesting"  six-levels 20 flatten one-to-eight 8 assert-cells= ;test

create trailing-null 1 , 2 , null ,
create one-two 1 , 2 ,
test" null values are omitted from the final result"  trailing-null 3 flatten one-two 2 assert-cells= ;test

create leading-nulls null , null , 3 ,
create just-three 3 ,
test" consecutive null values at the front of the array are omitted from the final result"
  leading-nulls 3 flatten just-three 1 assert-cells= ;test

create middle-nulls 1 , null , null , 4 ,
create one-four 1 , 4 ,
test" consecutive null values in the middle of the array are omitted from the final result"
  middle-nulls 4 flatten one-four 2 assert-cells= ;test

create six-levels-nulls
  0 , 2 , <[ , <[ , 2 , 3 , ]> , 8 , <[ , <[ , 100 , ]> , ]> , null , <[ , <[ , null , ]> , ]> , ]> , -2 ,
create six-levels-nulls-flat 0 , 2 , 2 , 3 , 8 , 100 , -2 ,
test" 6 level nested array with null values"  six-levels-nulls 21 flatten six-levels-nulls-flat 7 assert-cells= ;test

create all-nulls
  null , <[ , <[ , <[ , null , ]> , ]> , ]> , null , null , <[ , <[ , null , null , ]> , null , ]> , null ,
test" all values in nested array are null"  all-nulls 18 flatten nothing 0 assert-cells= ;test

end-tests
