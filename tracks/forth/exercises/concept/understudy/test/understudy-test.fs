require ../lib/test.fs
require ../understudy.fs

\ Every test that recasts the role gives it back to Amara at the end, so the tests do not depend
\ on their order.

test" 1. Amara plays Hamlet at first"  hamlet 1 assert= ;test
test" 1. Hamlet can be played twice in a row"  hamlet hamlet + 2 assert= ;test

test" 2. Chidi takes the role"  ['] chidi cast  hamlet 3 assert=  ['] amara cast ;test
test" 2. Bastien takes the role"  ['] bastien cast  hamlet 2 assert=  ['] amara cast ;test
test" 2. the last casting counts"  ['] chidi cast ['] bastien cast  hamlet 2 assert=  ['] amara cast ;test

test" 3. Amara is playing"  ['] amara cast  who-plays ['] amara assert= ;test
test" 3. Bastien is playing"  ['] bastien cast  who-plays ['] bastien assert=  ['] amara cast ;test

test" 4. Chidi plays one scene"  ['] amara cast  ['] chidi one-scene 3 assert= ;test
test" 4. Amara has the role back after the scene"  ['] amara cast  ['] chidi one-scene drop  hamlet 1 assert= ;test
test" 4. Bastien gets the role back from Amara"
  ['] bastien cast  ['] amara one-scene 1 assert=  who-plays ['] bastien assert=  ['] amara cast ;test

test" 5. one line left, Amara reads it"  1 amara-next assert-true ;test
test" 5. two lines, Amara first"  2 amara-next assert-false ;test
test" 5. seven lines, Amara first"  7 amara-next assert-true ;test
test" 5. one line left, Bastien reads it"  1 bastien-next assert-false ;test
test" 5. four lines, Bastien first"  4 bastien-next assert-true ;test

end-tests
