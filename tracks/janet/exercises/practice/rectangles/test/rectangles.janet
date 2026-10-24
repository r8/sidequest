(import test :as t)
(import ../rectangles :as sol)

(t/deftest "no rows"
  (t/assert-equal 0 (sol/count-rectangles [])))

(t/deftest "no columns"
  (t/assert-equal 0 (sol/count-rectangles [""])))

(t/deftest "no rectangles"
  (t/assert-equal 0 (sol/count-rectangles [" "])))

(t/deftest "one rectangle"
  (t/assert-equal 1 (sol/count-rectangles ["+-+" "| |" "+-+"])))

(t/deftest "two rectangles without shared parts"
  (t/assert-equal 2 (sol/count-rectangles ["  +-+" "  | |" "+-+-+" "| |  " "+-+  "])))

(t/deftest "five rectangles with shared parts"
  (t/assert-equal 5 (sol/count-rectangles ["  +-+" "  | |" "+-+-+" "| | |" "+-+-+"])))

(t/deftest "rectangle of height 1 is counted"
  (t/assert-equal 1 (sol/count-rectangles ["+--+" "+--+"])))

(t/deftest "rectangle of width 1 is counted"
  (t/assert-equal 1 (sol/count-rectangles ["++" "||" "++"])))

(t/deftest "1x1 square is counted"
  (t/assert-equal 1 (sol/count-rectangles ["++" "++"])))

(t/deftest "only complete rectangles are counted"
  (t/assert-equal 1 (sol/count-rectangles ["  +-+" "    |" "+-+-+" "| | -" "+-+-+"])))

(t/deftest "rectangles can be of different sizes"
  (t/assert-equal 3 (sol/count-rectangles ["+------+----+" "|      |    |" "+---+--+    |" "|   |       |" "+---+-------+"])))

(t/deftest "corner is required for a rectangle to be complete"
  (t/assert-equal 2 (sol/count-rectangles ["+------+----+" "|      |    |" "+------+    |" "|   |       |" "+---+-------+"])))

(t/deftest "large input with many rectangles"
  (t/assert-equal 60 (sol/count-rectangles ["+---+--+----+" "|   +--+----+" "+---+--+    |" "|   +--+----+" "+---+--+--+-+" "+---+--+--+-+" "+------+  | |" "          +-+"])))

(t/deftest "rectangles must have four sides"
  (t/assert-equal 5 (sol/count-rectangles ["+-+ +-+" "| | | |" "+-+-+-+" "  | |  " "+-+-+-+" "| | | |" "+-+ +-+"])))

(t/run)
