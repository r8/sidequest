(import test :as t)
(import ../strain :as sol)

(t/deftest "keep on empty list returns empty list"
  (t/assert-equal [] (sol/keep (fn [_] true) [])))

(t/deftest "keeps everything"
  (t/assert-equal [1 3 5] (sol/keep (fn [_] true) [1 3 5])))

(t/deftest "keeps nothing"
  (t/assert-equal [] (sol/keep (fn [_] false) [1 3 5])))

(t/deftest "keeps first and last"
  (t/assert-equal [1 3] (sol/keep odd? [1 2 3])))

(t/deftest "keeps neither first nor last"
  (t/assert-equal [2] (sol/keep even? [1 2 3])))

(t/deftest "keeps strings"
  (t/assert-equal ["zebra" "zombies" "zealot"] (sol/keep |(string/has-prefix? "z" $) ["apple" "zebra" "banana" "zombies" "cherimoya" "zealot"])))

(t/deftest "keeps lists"
  (t/assert-equal [[5 5 5] [5 1 2] [1 5 2] [1 2 5]] (sol/keep |(has-value? $ 5) [[1 2 3] [5 5 5] [5 1 2] [2 1 2] [1 5 2] [2 2 1] [1 2 5]])))

(t/deftest "discard on empty list returns empty list"
  (t/assert-equal [] (sol/discard (fn [_] true) [])))

(t/deftest "discards everything"
  (t/assert-equal [] (sol/discard (fn [_] true) [1 3 5])))

(t/deftest "discards nothing"
  (t/assert-equal [1 3 5] (sol/discard (fn [_] false) [1 3 5])))

(t/deftest "discards first and last"
  (t/assert-equal [2] (sol/discard odd? [1 2 3])))

(t/deftest "discards neither first nor last"
  (t/assert-equal [1 3] (sol/discard even? [1 2 3])))

(t/deftest "discards strings"
  (t/assert-equal ["apple" "banana" "cherimoya"] (sol/discard |(string/has-prefix? "z" $) ["apple" "zebra" "banana" "zombies" "cherimoya" "zealot"])))

(t/deftest "discards lists"
  (t/assert-equal [[1 2 3] [2 1 2] [2 2 1]] (sol/discard |(has-value? $ 5) [[1 2 3] [5 5 5] [5 1 2] [2 1 2] [1 5 2] [2 2 1] [1 2 5]])))

(t/run)
