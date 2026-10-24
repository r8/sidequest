require ../lib/test.fs
require ../piggy-bank.fs

test" 1. a penny"  penny 1 assert= ;test
test" 1. a nickel"  nickel 5 assert= ;test
test" 1. a dime"  dime 10 assert= ;test
test" 1. a quarter"  quarter 25 assert= ;test
test" 1. coins add up"  3 dime * nickel + penny + 36 assert= ;test

test" 2. an empty bank"  empty-bank balance 0 assert= ;test
test" 2. reading the balance does not change it"  empty-bank balance drop balance 0 assert= ;test

test" 3. one coin"  empty-bank quarter deposit balance 25 assert= ;test
test" 3. two coins"  empty-bank quarter deposit dime deposit balance 35 assert= ;test
test" 3. emptying the bank after deposits"  empty-bank 500 deposit empty-bank balance 0 assert= ;test
test" 3. many deposits"  empty-bank 10 deposit 20 deposit 30 deposit 40 deposit balance 100 assert= ;test

test" 4. taking out part of the savings"  empty-bank 100 deposit 30 withdraw 30 assert= balance 70 assert= ;test
test" 4. taking out more than there is"  empty-bank 20 deposit 50 withdraw 20 assert= balance 0 assert= ;test
test" 4. taking out exactly everything"  empty-bank 45 deposit 45 withdraw 45 assert= balance 0 assert= ;test
test" 4. taking out of an empty bank"  empty-bank 10 withdraw 0 assert= balance 0 assert= ;test

test" 5. the goal starts at the price of the bike"  goal 12000 assert= ;test
test" 5. not there yet"  empty-bank 5000 deposit goal-reached? assert-false ;test
test" 5. exactly at the goal"  empty-bank 12000 deposit goal-reached? assert-true ;test
test" 5. a lower goal"  9500 set-goal goal 9500 assert= empty-bank 9500 deposit goal-reached? assert-true ;test
test" 5. a higher goal"  15000 set-goal empty-bank 12000 deposit goal-reached? assert-false ;test

end-tests
