require ../lib/test.fs
require ../locker-room.fs

test" 1. a new locker is laid down at here"  here 1042 7319 new-locker assert= ;test
test" 1. a new locker takes three cells"  1042 7319 new-locker here swap - 3 cells assert= ;test
test" 1. two lockers are different"  1 2 new-locker 3 4 new-locker <> assert-true ;test

test" 2. the owner"  1042 7319 new-locker owner 1042 assert= ;test
test" 2. the combination"  1042 7319 new-locker combination 7319 assert= ;test
test" 2. the owner is the first cell"  1042 7319 new-locker @ 1042 assert= ;test
test" 2. the combination is the second cell"  1042 7319 new-locker cell+ @ 7319 assert= ;test

test" 3. a new locker is closed"  1042 7319 new-locker open? assert-false ;test
test" 3. the right combination opens it"  1042 7319 new-locker  7319 over try-open assert-true  open? assert-true ;test
test" 3. a wrong combination does not"  1042 7319 new-locker  1234 over try-open assert-false  open? assert-false ;test
test" 3. the open flag is the third cell"  1042 7319 new-locker  7319 over try-open drop  2 cells + @ assert-true ;test
test" 3. a wrong combination leaves an open locker open"
  1042 7319 new-locker  7319 over try-open drop  1234 over try-open assert-false  open? assert-true ;test

test" 4. locking an open locker"  1042 7319 new-locker  7319 over try-open drop  dup lock-up  open? assert-false ;test
test" 4. locking a closed locker"  1042 7319 new-locker  dup lock-up  open? assert-false ;test
test" 4. locking keeps the owner"  1042 7319 new-locker  dup lock-up  owner 1042 assert= ;test

test" 5. the new owner"  1042 7319 new-locker  2001 1111 2 pick reassign  owner 2001 assert= ;test
test" 5. the new combination"  1042 7319 new-locker  2001 1111 2 pick reassign  combination 1111 assert= ;test
test" 5. a reassigned locker is closed"
  1042 7319 new-locker  7319 over try-open drop  2001 1111 2 pick reassign  open? assert-false ;test
test" 5. the old combination no longer opens it"
  1042 7319 new-locker  2001 1111 2 pick reassign  7319 over try-open assert-false  drop ;test

end-tests
