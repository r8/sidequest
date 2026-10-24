(import test :as t)
(import ../scrabble-score :as sol)

(t/deftest "lowercase letter"
  (t/assert-equal 1 (sol/score "a")))

(t/deftest "uppercase letter"
  (t/assert-equal 1 (sol/score "A")))

(t/deftest "valuable letter"
  (t/assert-equal 4 (sol/score "f")))

(t/deftest "short word"
  (t/assert-equal 2 (sol/score "at")))

(t/deftest "short, valuable word"
  (t/assert-equal 12 (sol/score "zoo")))

(t/deftest "medium word"
  (t/assert-equal 6 (sol/score "street")))

(t/deftest "medium, valuable word"
  (t/assert-equal 22 (sol/score "quirky")))

(t/deftest "long, mixed-case word"
  (t/assert-equal 41 (sol/score "OxyphenButazone")))

(t/deftest "english-like word"
  (t/assert-equal 8 (sol/score "pinata")))

(t/deftest "empty input"
  (t/assert-equal 0 (sol/score "")))

(t/deftest "entire alphabet available"
  (t/assert-equal 87 (sol/score "abcdefghijklmnopqrstuvwxyz")))

(t/run)
