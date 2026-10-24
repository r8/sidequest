require ../lib/test.fs
require ../remote-control.fs

:noname ( n -- 3n ) 3 * ; constant triple

test" 1. two steps louder"  3 ['] louder twice 5 assert= ;test
test" 1. louder twice stops at the loudest"  9 ['] louder twice 10 assert= ;test
test" 1. mute twice"  5 ['] mute twice 0 assert= ;test
test" 1. any word can be run twice"  2 ['] 1+ twice 4 assert= ;test
test" 1. a word without a name"  2 triple twice 18 assert= ;test

test" 2. button 0 is louder"  0 button ['] louder assert= ;test
test" 2. button 1 is quieter"  1 button ['] quieter assert= ;test
test" 2. button 2 is mute"  2 button ['] mute assert= ;test
test" 2. button 3 is loudest"  3 button ['] loudest assert= ;test

test" 3. press louder"  4 0 press 5 assert= ;test
test" 3. press quieter"  4 1 press 3 assert= ;test
test" 3. press mute"  7 2 press 0 assert= ;test
test" 3. press loudest"  2 3 press 10 assert= ;test
test" 3. quieter stops at silence"  0 1 press 0 assert= ;test

create bedtime  2 , 0 , 0 ,
create party  3 , 1 , 1 , 1 ,
test" 4. mute, then two steps louder"  8 bedtime 3 press-all 2 assert= ;test
test" 4. loudest, then three steps quieter"  0 party 4 press-all 7 assert= ;test
test" 4. an empty sequence changes nothing"  5 bedtime 0 press-all 5 assert= ;test
test" 4. a single press"  5 party 1 press-all 10 assert= ;test

create rooms  3 , 7 , 10 ,
create rooms-louder  4 , 8 , 10 ,
test" 5. every room one step louder"  rooms 3 ['] louder apply-to-all  rooms 3 rooms-louder 3 assert-cells= ;test

create hall  5 , 0 , 9 , 2 ,
create hall-muted  0 , 0 , 0 , 0 ,
test" 5. every room muted"  hall 4 ['] mute apply-to-all  hall 4 hall-muted 4 assert-cells= ;test

create lobby  1 , 2 ,
create lobby-tripled  3 , 6 ,
test" 5. a word without a name"  lobby 2 triple apply-to-all  lobby 2 lobby-tripled 2 assert-cells= ;test

create nothing
test" 5. no rooms"  nothing 0 ['] louder apply-to-all ;test

end-tests
