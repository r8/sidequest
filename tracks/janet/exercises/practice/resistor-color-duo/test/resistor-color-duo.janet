(import test :as t)
(import ../resistor-color-duo :as sol)

(t/deftest "Brown and black"
  (t/assert-equal 10 (sol/value [:brown :black])))

(t/deftest "Blue and grey"
  (t/assert-equal 68 (sol/value [:blue :grey])))

(t/deftest "Yellow and violet"
  (t/assert-equal 47 (sol/value [:yellow :violet])))

(t/deftest "White and red"
  (t/assert-equal 92 (sol/value [:white :red])))

(t/deftest "Orange and orange"
  (t/assert-equal 33 (sol/value [:orange :orange])))

(t/deftest "Ignore additional colors"
  (t/assert-equal 51 (sol/value [:green :brown :orange])))

(t/deftest "Black and brown, one-digit"
  (t/assert-equal 1 (sol/value [:black :brown])))

(t/run)
