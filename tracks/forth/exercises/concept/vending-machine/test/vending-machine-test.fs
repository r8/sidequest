require ../lib/test.fs
require ../vending-machine.fs

\ A word that throws takes its arguments from these helpers, as assert-xt-throws runs an xt
\ with no arguments.
: short-by-50 ( -- change ) 150 100 change ;
: short-by-1 ( -- change ) 100 99 change ;
: empty-slot ( -- stock' ) 0 take-one ;

test" 1. change for more than the price"  150 200 change 50 assert= ;test
test" 1. no change for the exact price"  120 120 change 0 assert= ;test
test" 1. not enough money"  ['] short-by-50 not-enough-money assert-xt-throws ;test
test" 1. a penny short"  ['] short-by-1 not-enough-money assert-xt-throws ;test

test" 2. take one of three"  3 take-one 2 assert= ;test
test" 2. take the last one"  1 take-one 0 assert= ;test
test" 2. an empty slot is sold out"  ['] empty-slot sold-out assert-xt-throws ;test

test" 3. a slot in the middle"  7 check-slot 7 assert= ;test
test" 3. the first and last slots"  1 check-slot 1 assert=  12 check-slot 12 assert= ;test
test" 3. a slot past the last"  13 ['] check-slot -24 assert-throws ;test
test" 3. slot zero"  0 ['] check-slot -24 assert-throws ;test
test" 3. a negative slot"  -3 ['] check-slot -24 assert-throws ;test

test" 4. change when there is enough"  150 200 change-or-refund 50 assert= ;test
test" 4. a refund when the money is short"  150 100 change-or-refund 100 assert= ;test
test" 4. a refund of a single coin"  80 20 change-or-refund 20 assert= ;test

\ Faults for guarded: each sets credit first, so the test sees whether guarded cleared it.
: fine ( -- ) 70 credit ! ;
: jammed ( -- ) 70 credit !  5 throw ;
: empty ( -- ) 70 credit !  empty-slot drop ;
test" 5. a word that finishes leaves 0"  ['] fine guarded 0 assert=  credit @ 70 assert= ;test
test" 5. a fault leaves its code"  ['] jammed guarded 5 assert= ;test
test" 5. a fault returns the credit"  ['] jammed guarded drop  credit @ 0 assert= ;test
test" 5. a sold-out slot inside the word"  ['] empty guarded sold-out assert=  credit @ 0 assert= ;test

end-tests
