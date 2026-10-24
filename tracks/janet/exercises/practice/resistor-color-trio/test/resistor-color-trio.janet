(import test :as t)
(import ../resistor-color-trio :as sol)

(t/deftest "Orange and orange and black"
  (t/assert-equal {:value 33 :unit :ohms} (sol/resistance [:orange :orange :black])))

(t/deftest "Blue and grey and brown"
  (t/assert-equal {:value 680 :unit :ohms} (sol/resistance [:blue :grey :brown])))

(t/deftest "Red and black and red"
  (t/assert-equal {:value 2 :unit :kiloohms} (sol/resistance [:red :black :red])))

(t/deftest "Green and brown and orange"
  (t/assert-equal {:value 51 :unit :kiloohms} (sol/resistance [:green :brown :orange])))

(t/deftest "Yellow and violet and yellow"
  (t/assert-equal {:value 470 :unit :kiloohms} (sol/resistance [:yellow :violet :yellow])))

(t/deftest "Blue and violet and blue"
  (t/assert-equal {:value 67 :unit :megaohms} (sol/resistance [:blue :violet :blue])))

(t/deftest "Minimum possible value"
  (t/assert-equal {:value 0 :unit :ohms} (sol/resistance [:black :black :black])))

(t/deftest "Maximum possible value"
  (t/assert-equal {:value 99 :unit :gigaohms} (sol/resistance [:white :white :white])))

(t/deftest "First two colors make an invalid octal number"
  (t/assert-equal {:value 8 :unit :ohms} (sol/resistance [:black :grey :black])))

(t/deftest "Ignore extra colors"
  (t/assert-equal {:value 650 :unit :kiloohms} (sol/resistance [:blue :green :yellow :orange])))

(t/run)
