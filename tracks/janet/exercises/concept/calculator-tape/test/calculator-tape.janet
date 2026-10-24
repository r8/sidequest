(import test :as t)
(import ../calculator-tape :as sol)

(t/deftest "1. a whole amount"
  (t/assert-equal 120 (sol/parse-amount "120")))

(t/deftest "1. an amount with decimals"
  (t/assert-equal 15.5 (sol/parse-amount "15.50")))

(t/deftest "1. a negative amount"
  (t/assert-equal -3 (sol/parse-amount "-3")))

(t/deftest "1. a trailing dot is not an amount"
  (t/assert-equal nil (sol/parse-amount "15.")))

(t/deftest "1. trailing text is not an amount"
  (t/assert-equal nil (sol/parse-amount "12 apples")))

(t/deftest "2. an addition"
  (t/assert-equal [:add 120] (sol/parse-entry "+ 120")))

(t/deftest "2. a subtraction with decimals"
  (t/assert-equal [:sub 15.5] (sol/parse-entry "- 15.50")))

(t/deftest "2. a multiplication and a division, with extra spaces"
  (t/assert-equal [[:mul 2] [:div -4]] [(sol/parse-entry "*   2") (sol/parse-entry "/ -4")]))

(t/deftest "2. an unknown operator"
  (t/assert-equal nil (sol/parse-entry "% 3")))

(t/deftest "2. a missing space"
  (t/assert-equal nil (sol/parse-entry "+120")))

(t/deftest "3. a tape with one entry"
  (t/assert-equal [[:add 7]] (sol/parse-tape "+ 7")))

(t/deftest "3. a tape with a final newline"
  (t/assert-equal [[:add 120] [:sub 15.5] [:mul 2]] (sol/parse-tape "+ 120\n- 15.50\n* 2\n")))

(t/deftest "3. a tape with a smudged line"
  (t/assert-equal nil (sol/parse-tape "+ 120\n- 1#.50\n* 2")))

(t/deftest "3. an empty line in the middle"
  (t/assert-equal nil (sol/parse-tape "+ 1\n\n+ 2")))

(t/deftest "4. totalling one entry"
  (t/assert-equal 42 (sol/tape-total "+ 42")))

(t/deftest "4. totalling in order"
  (t/assert-equal 209 (sol/tape-total "+ 120\n- 15.50\n* 2")))

(t/deftest "4. every operator"
  (t/assert-equal 5 (sol/tape-total "+ 10\n* 3\n- 5\n/ 5\n")))

(t/deftest "5. a single number"
  (t/assert-equal 7 (sol/evaluate "7")))

(t/deftest "5. left to right"
  (t/assert-equal 4 (sol/evaluate "10 - 3 - 3")))

(t/deftest "5. parentheses"
  (t/assert-equal 100 (sol/evaluate "120 - (15 + 5)")))

(t/deftest "5. nested parentheses, without spaces"
  (t/assert-equal 15 (sol/evaluate "10-(2-(3+4))")))

(t/deftest "5. unbalanced parentheses"
  (t/assert-equal nil (sol/evaluate "1 + (2")))

(t/run)
