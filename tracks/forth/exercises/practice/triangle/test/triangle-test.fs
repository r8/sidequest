require ../lib/test.fs
require ../triangle.fs

test" equilateral triangle > all sides are equal"  2e 2e 2e equilateral? assert-true ;test
test" equilateral triangle > any side is unequal"  2e 3e 2e equilateral? assert-false ;test
test" equilateral triangle > no sides are equal"  5e 4e 6e equilateral? assert-false ;test
test" equilateral triangle > all zero sides is not a triangle"  0e 0e 0e equilateral? assert-false ;test
test" equilateral triangle > sides may be floats"  0.5e 0.5e 0.5e equilateral? assert-true ;test
test" isosceles triangle > last two sides are equal"  3e 4e 4e isosceles? assert-true ;test
test" isosceles triangle > first two sides are equal"  4e 4e 3e isosceles? assert-true ;test
test" isosceles triangle > first and last sides are equal"  4e 3e 4e isosceles? assert-true ;test
test" isosceles triangle > equilateral triangles are also isosceles"  4e 4e 4e isosceles? assert-true ;test
test" isosceles triangle > no sides are equal"  2e 3e 4e isosceles? assert-false ;test
test" isosceles triangle > first triangle inequality violation"  1e 1e 3e isosceles? assert-false ;test
test" isosceles triangle > second triangle inequality violation"  1e 3e 1e isosceles? assert-false ;test
test" isosceles triangle > third triangle inequality violation"  3e 1e 1e isosceles? assert-false ;test
test" isosceles triangle > sides may be floats"  0.5e 0.4e 0.5e isosceles? assert-true ;test
test" scalene triangle > no sides are equal"  5e 4e 6e scalene? assert-true ;test
test" scalene triangle > all sides are equal"  4e 4e 4e scalene? assert-false ;test
test" scalene triangle > first and second sides are equal"  4e 4e 3e scalene? assert-false ;test
test" scalene triangle > first and third sides are equal"  3e 4e 3e scalene? assert-false ;test
test" scalene triangle > second and third sides are equal"  4e 3e 3e scalene? assert-false ;test
test" scalene triangle > may not violate triangle inequality"  7e 3e 2e scalene? assert-false ;test
test" scalene triangle > sides may be floats"  0.5e 0.4e 0.6e scalene? assert-true ;test

end-tests
