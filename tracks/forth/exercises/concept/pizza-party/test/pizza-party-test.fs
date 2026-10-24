require ../lib/test.fs
require ../pizza-party.fs

test" 1. a thirty centimetre pizza"  30e pizza-area 706.86e assert-f~ ;test
test" 1. a twenty centimetre pizza"  20e pizza-area 314.16e assert-f~ ;test
test" 1. a party-size pizza"  45e pizza-area 1590.43e assert-f~ ;test
test" 1. no pizza at all"  0e pizza-area 0e assert-f~ ;test

test" 2. eight slices of a thirty centimetre pizza"  30e 8 slice-area 88.36e assert-f~ ;test
test" 2. six slices of a twenty centimetre pizza"  20e 6 slice-area 52.36e assert-f~ ;test
test" 2. a whole pizza as one slice"  20e 1 slice-area 314.16e assert-f~ ;test

test" 3. the large pizza is the better deal"  30e 12e 20e 8e better-deal? assert-true ;test
test" 3. the small pizza is not the better deal"  20e 8e 30e 12e better-deal? assert-false ;test
test" 3. the same offer twice is not a better deal"  20e 8e 20e 8e better-deal? assert-false ;test
test" 3. a cheap small pizza beats a dear large one"  20e 5e 30e 15e better-deal? assert-true ;test

test" 4. ten players eating three slices each"  10 0.375e pizzas-needed 4 assert= ;test
test" 4. an exact number of pizzas"  8 0.5e pizzas-needed 4 assert= ;test
test" 4. a small appetite still needs a pizza"  3 0.25e pizzas-needed 1 assert= ;test
test" 4. no players need no pizza"  0 0.5e pizzas-needed 0 assert= ;test

test" 5. a tip rounded down"  42e tip 6e assert-f~ ;test
test" 5. a tip rounded up"  37e tip 6e assert-f~ ;test
test" 5. a whole tip"  60e tip 9e assert-f~ ;test
test" 5. a bill with cents"  75.2e tip 11e assert-f~ ;test

end-tests
