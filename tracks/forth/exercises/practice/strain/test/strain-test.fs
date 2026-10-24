require ../lib/test.fs
require ../strain.fs

: always ( x -- true ) drop true ;
create no-numbers
test" keep on empty list returns empty list"  no-numbers 0 ['] always keep no-numbers 0 assert-cells= ;test

create one-three-five 1 , 3 , 5 ,
test" keeps everything"  one-three-five 3 ['] always keep one-three-five 3 assert-cells= ;test

: never ( x -- false ) drop false ;
test" keeps nothing"  one-three-five 3 ['] never keep no-numbers 0 assert-cells= ;test

: odd? ( n -- flag ) 1 and 0<> ;
create one-two-three 1 , 2 , 3 ,
create one-three 1 , 3 ,
test" keeps first and last"  one-two-three 3 ['] odd? keep one-three 2 assert-cells= ;test

: even? ( n -- flag ) 1 and 0= ;
create just-two 2 ,
test" keeps neither first nor last"  one-two-three 3 ['] even? keep just-two 1 assert-cells= ;test

\ The strings are counted strings; the cells hold their addresses.
: apple ( -- c-addr ) c" apple" ;
: zebra ( -- c-addr ) c" zebra" ;
: banana ( -- c-addr ) c" banana" ;
: zombies ( -- c-addr ) c" zombies" ;
: cherimoya ( -- c-addr ) c" cherimoya" ;
: zealot ( -- c-addr ) c" zealot" ;
create fruits apple , zebra , banana , zombies , cherimoya , zealot ,
create z-fruits zebra , zombies , zealot ,
: starts-with-z? ( c-addr -- flag ) count if c@ [char] z = else drop false then ;
test" keeps strings"  fruits 6 ['] starts-with-z? keep z-fruits 3 assert-cells= ;test

\ The lists are counted lists (the count, then the elements); the cells hold their addresses.
create list-123 3 , 1 , 2 , 3 ,
create list-555 3 , 5 , 5 , 5 ,
create list-512 3 , 5 , 1 , 2 ,
create list-212 3 , 2 , 1 , 2 ,
create list-152 3 , 1 , 5 , 2 ,
create list-221 3 , 2 , 2 , 1 ,
create list-125 3 , 1 , 2 , 5 ,
create lists list-123 , list-555 , list-512 , list-212 , list-152 , list-221 , list-125 ,
create lists-with-5 list-555 , list-512 , list-152 , list-125 ,
: contains-5? ( list -- flag ) false swap dup @ 0 ?do cell+ dup @ 5 = rot or swap loop drop ;
test" keeps lists"  lists 7 ['] contains-5? keep lists-with-5 4 assert-cells= ;test

test" discard on empty list returns empty list"  no-numbers 0 ['] always discard no-numbers 0 assert-cells= ;test
test" discards everything"  one-three-five 3 ['] always discard no-numbers 0 assert-cells= ;test
test" discards nothing"  one-three-five 3 ['] never discard one-three-five 3 assert-cells= ;test
test" discards first and last"  one-two-three 3 ['] odd? discard just-two 1 assert-cells= ;test
test" discards neither first nor last"  one-two-three 3 ['] even? discard one-three 2 assert-cells= ;test

create other-fruits apple , banana , cherimoya ,
test" discards strings"  fruits 6 ['] starts-with-z? discard other-fruits 3 assert-cells= ;test

create lists-without-5 list-123 , list-212 , list-221 ,
test" discards lists"  lists 7 ['] contains-5? discard lists-without-5 3 assert-cells= ;test

end-tests
