require ../lib/test.fs
require ../guest-list.fs

\ The tests free every string and block they are given.
: free-string ( c-addr u -- ) drop free throw ;
variable kept  variable #kept

create original 5 chars allot
test" 1. a copy has the same characters"  s" Ada" copy-name 2dup s" Ada" assert-str= free-string ;test
test" 1. a copy outlives the original"
  s" Grace" original swap chars move
  original 5 copy-name #kept ! kept !
  original 5 [char] x fill
  kept @ #kept @ s" Grace" assert-str=  kept @ #kept @ free-string ;test
test" 1. two copies are kept apart"
  s" Ada" copy-name #kept ! kept !
  s" Bob" copy-name
  kept @ #kept @ s" Ada" assert-str=  2dup s" Bob" assert-str=
  free-string  kept @ #kept @ free-string ;test
test" 1. an empty name"  s" " copy-name 2dup s" " assert-str= free-string ;test

test" 2. a place card"  s" Ada" s" Lovelace" full-name 2dup s" Ada Lovelace" assert-str= free-string ;test
test" 2. a short place card"  s" Bo" s" Li" full-name 2dup s" Bo Li" assert-str= free-string ;test
test" 2. two place cards are kept apart"
  s" Ada" s" Lovelace" full-name #kept ! kept !
  s" Alan" s" Turing" full-name
  kept @ #kept @ s" Ada Lovelace" assert-str=  2dup s" Alan Turing" assert-str=
  free-string  kept @ #kept @ free-string ;test

create no-guests 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,
test" 3. eight empty seats"  8 guest-slots dup 8 no-guests 8 assert-cells= free throw ;test
test" 3. one empty seat"  1 guest-slots dup 1 no-guests 1 assert-cells= free throw ;test
test" 3. seats can be filled"
  3 guest-slots  dup 7 swap cell+ !  dup @ 0 assert=  dup cell+ @ 7 assert=  free throw ;test

create two-guests 7 , 8 ,
create two-guests-and-room 7 , 8 , 0 , 0 ,
create three-guests 4 , 5 , 6 ,
: seats-with ( addr n -- addr2 ) dup cells allocate throw  dup >r swap cells move  r> ;
test" 4. a bigger room keeps the guests"
  two-guests 2 seats-with  2 4 resize-slots  dup 4 two-guests-and-room 4 assert-cells=  free throw ;test
test" 4. a smaller room keeps the first guests"
  three-guests 3 seats-with  3 2 resize-slots  dup 2 three-guests 2 assert-cells=  free throw ;test
test" 4. a room from empty seats"
  2 guest-slots 2 8 resize-slots  dup 8 no-guests 8 assert-cells=  free throw ;test

end-tests
