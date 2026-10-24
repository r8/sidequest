(import test :as t)
(import ../transpose :as sol)

(t/deftest "empty string"
  (t/assert-equal [] (sol/transpose [])))

(t/deftest "two characters in a row"
  (t/assert-equal ["A" "1"] (sol/transpose ["A1"])))

(t/deftest "two characters in a column"
  (t/assert-equal ["A1"] (sol/transpose ["A" "1"])))

(t/deftest "simple"
  (t/assert-equal ["A1" "B2" "C3"] (sol/transpose ["ABC" "123"])))

(t/deftest "single line"
  (t/assert-equal ["S" "i" "n" "g" "l" "e" " " "l" "i" "n" "e" "."] (sol/transpose ["Single line."])))

(t/deftest "first line longer than second line"
  (t/assert-equal ["TT" "hh" "ee" "  " "ff" "oi" "uf" "rt" "th" "h " " l" "li" "in" "ne" "e." "."] (sol/transpose ["The fourth line." "The fifth line."])))

(t/deftest "second line longer than first line"
  (t/assert-equal ["TT" "hh" "ee" "  " "fs" "ie" "rc" "so" "tn" " d" "l " "il" "ni" "en" ".e" " ."] (sol/transpose ["The first line." "The second line."])))

(t/deftest "mixed line length"
  (t/assert-equal ["TAAA" "h   " "elll" " ooi" "lnnn" "ogge" "n e." "glr" "ei " "snl" "tei" " .n" "l e" "i ." "n" "e" "."] (sol/transpose ["The longest line." "A long line." "A longer line." "A line."])))

(t/deftest "square"
  (t/assert-equal ["HEART" "EMBER" "ABUSE" "RESIN" "TREND"] (sol/transpose ["HEART" "EMBER" "ABUSE" "RESIN" "TREND"])))

(t/deftest "rectangle"
  (t/assert-equal ["FOBS" "RULE" "ATOP" "CLOT" "TIME" "UNIT" "RENT" "EDGE"] (sol/transpose ["FRACTURE" "OUTLINED" "BLOOMING" "SEPTETTE"])))

(t/deftest "triangle"
  (t/assert-equal ["TEASER" " EASER" "  ASER" "   SER" "    ER" "     R"] (sol/transpose ["T" "EE" "AAA" "SSSS" "EEEEE" "RRRRRR"])))

(t/deftest "jagged triangle"
  (t/assert-equal ["123456" "1 3456" "  3456" "  3 56" "    56" "    5"] (sol/transpose ["11" "2" "3333" "444" "555555" "66666"])))

(t/run)
