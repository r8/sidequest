import test
import triangle

pub fun main()
  run([
    test("equilateral triangle > all sides are equal") { assert-true(equilateral(2.0, 2.0, 2.0)) },
    test("equilateral triangle > any side is unequal") { assert-false(equilateral(2.0, 3.0, 2.0)) },
    test("equilateral triangle > no sides are equal") { assert-false(equilateral(5.0, 4.0, 6.0)) },
    test("equilateral triangle > all zero sides is not a triangle") { assert-false(equilateral(0.0, 0.0, 0.0)) },
    test("equilateral triangle > sides may be floats") { assert-true(equilateral(0.5, 0.5, 0.5)) },
    test("isosceles triangle > last two sides are equal") { assert-true(isosceles(3.0, 4.0, 4.0)) },
    test("isosceles triangle > first two sides are equal") { assert-true(isosceles(4.0, 4.0, 3.0)) },
    test("isosceles triangle > first and last sides are equal") { assert-true(isosceles(4.0, 3.0, 4.0)) },
    test("isosceles triangle > equilateral triangles are also isosceles") { assert-true(isosceles(4.0, 4.0, 4.0)) },
    test("isosceles triangle > no sides are equal") { assert-false(isosceles(2.0, 3.0, 4.0)) },
    test("isosceles triangle > first triangle inequality violation") { assert-false(isosceles(1.0, 1.0, 3.0)) },
    test("isosceles triangle > second triangle inequality violation") { assert-false(isosceles(1.0, 3.0, 1.0)) },
    test("isosceles triangle > third triangle inequality violation") { assert-false(isosceles(3.0, 1.0, 1.0)) },
    test("isosceles triangle > sides may be floats") { assert-true(isosceles(0.5, 0.4, 0.5)) },
    test("scalene triangle > no sides are equal") { assert-true(scalene(5.0, 4.0, 6.0)) },
    test("scalene triangle > all sides are equal") { assert-false(scalene(4.0, 4.0, 4.0)) },
    test("scalene triangle > first and second sides are equal") { assert-false(scalene(4.0, 4.0, 3.0)) },
    test("scalene triangle > first and third sides are equal") { assert-false(scalene(3.0, 4.0, 3.0)) },
    test("scalene triangle > second and third sides are equal") { assert-false(scalene(4.0, 3.0, 3.0)) },
    test("scalene triangle > may not violate triangle inequality") { assert-false(scalene(7.0, 3.0, 2.0)) },
    test("scalene triangle > sides may be floats") { assert-true(scalene(0.5, 0.4, 0.6)) },
  ])
