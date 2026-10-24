require ../lib/test.fs
require ../resistor-color.fs

test" Color codes > Black"  s" black" color-code 0 assert= ;test
test" Color codes > White"  s" white" color-code 9 assert= ;test
test" Color codes > Orange"  s" orange" color-code 3 assert= ;test
test" Colors"  colors s" black brown red orange yellow green blue violet grey white" assert-str= ;test

end-tests
