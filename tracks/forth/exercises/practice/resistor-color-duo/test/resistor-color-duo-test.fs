require ../lib/test.fs
require ../resistor-color-duo.fs

test" Brown and black"  s" brown" s" black" resistor-value 10 assert= ;test
test" Blue and grey"  s" blue" s" grey" resistor-value 68 assert= ;test
test" Yellow and violet"  s" yellow" s" violet" resistor-value 47 assert= ;test
test" White and red"  s" white" s" red" resistor-value 92 assert= ;test
test" Orange and orange"  s" orange" s" orange" resistor-value 33 assert= ;test
\ Canonical: green, brown, orange; only the first two bands reach the word.
test" Ignore additional colors"  s" green" s" brown" resistor-value 51 assert= ;test
test" Black and brown, one-digit"  s" black" s" brown" resistor-value 1 assert= ;test

end-tests
