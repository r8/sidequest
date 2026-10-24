(import test :as t)
(import ../resistor-color :as sol)

(t/deftest "Black"
  (t/assert-equal 0 (sol/color-code :black)))

(t/deftest "White"
  (t/assert-equal 9 (sol/color-code :white)))

(t/deftest "Orange"
  (t/assert-equal 3 (sol/color-code :orange)))

(t/deftest "Colors"
  (t/assert-equal [:black :brown :red :orange :yellow :green :blue :violet :grey :white] (sol/colors)))

(t/run)
