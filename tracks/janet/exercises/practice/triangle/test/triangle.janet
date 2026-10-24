(import test :as t)
(import ../triangle :as sol)

(t/deftest "all sides are equal"
  (t/assert-true (sol/equilateral? 2 2 2)))

(t/deftest "any side is unequal"
  (t/assert-false (sol/equilateral? 2 3 2)))

(t/deftest "no sides are equal"
  (t/assert-false (sol/equilateral? 5 4 6)))

(t/deftest "all zero sides is not a triangle"
  (t/assert-false (sol/equilateral? 0 0 0)))

(t/deftest "sides may be floats"
  (t/assert-true (sol/equilateral? 0.5 0.5 0.5)))

(t/deftest "last two sides are equal"
  (t/assert-true (sol/isosceles? 3 4 4)))

(t/deftest "first two sides are equal"
  (t/assert-true (sol/isosceles? 4 4 3)))

(t/deftest "first and last sides are equal"
  (t/assert-true (sol/isosceles? 4 3 4)))

(t/deftest "equilateral triangles are also isosceles"
  (t/assert-true (sol/isosceles? 4 4 4)))

(t/deftest "isosceles triangle > no sides are equal"
  (t/assert-false (sol/isosceles? 2 3 4)))

(t/deftest "first triangle inequality violation"
  (t/assert-false (sol/isosceles? 1 1 3)))

(t/deftest "second triangle inequality violation"
  (t/assert-false (sol/isosceles? 1 3 1)))

(t/deftest "third triangle inequality violation"
  (t/assert-false (sol/isosceles? 3 1 1)))

(t/deftest "isosceles triangle > sides may be floats"
  (t/assert-true (sol/isosceles? 0.5 0.4 0.5)))

(t/deftest "scalene triangle > no sides are equal"
  (t/assert-true (sol/scalene? 5 4 6)))

(t/deftest "scalene triangle > all sides are equal"
  (t/assert-false (sol/scalene? 4 4 4)))

(t/deftest "first and second sides are equal"
  (t/assert-false (sol/scalene? 4 4 3)))

(t/deftest "first and third sides are equal"
  (t/assert-false (sol/scalene? 3 4 3)))

(t/deftest "second and third sides are equal"
  (t/assert-false (sol/scalene? 4 3 3)))

(t/deftest "may not violate triangle inequality"
  (t/assert-false (sol/scalene? 7 3 2)))

(t/deftest "scalene triangle > sides may be floats"
  (t/assert-true (sol/scalene? 0.5 0.4 0.6)))

(t/run)
