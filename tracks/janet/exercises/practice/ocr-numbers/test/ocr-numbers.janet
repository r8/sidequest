(import test :as t)
(import ../ocr-numbers :as sol)

(t/deftest "Recognizes 0"
  (t/assert-equal "0"
    (sol/convert [" _ "
                  "| |"
                  "|_|"
                  "   "])))

(t/deftest "Recognizes 1"
  (t/assert-equal "1"
    (sol/convert ["   "
                  "  |"
                  "  |"
                  "   "])))

(t/deftest "Unreadable but correctly sized inputs return ?"
  (t/assert-equal "?"
    (sol/convert ["   "
                  "  _"
                  "  |"
                  "   "])))

(t/deftest "Input with a number of lines that is not a multiple of four raises an error"
  (t/assert-error "Number of input lines is not a multiple of four"
    (sol/convert [" _ "
                  "| |"
                  "   "])))

(t/deftest "Input with a number of columns that is not a multiple of three raises an error"
  (t/assert-error "Number of input columns is not a multiple of three"
    (sol/convert ["    "
                  "   |"
                  "   |"
                  "    "])))

(t/deftest "Recognizes 110101100"
  (t/assert-equal "110101100"
    (sol/convert ["       _     _        _  _ "
                  "  |  || |  || |  |  || || |"
                  "  |  ||_|  ||_|  |  ||_||_|"
                  "                           "])))

(t/deftest "Garbled numbers in a string are replaced with ?"
  (t/assert-equal "11?10?1?0"
    (sol/convert ["       _     _           _ "
                  "  |  || |  || |     || || |"
                  "  |  | _|  ||_|  |  ||_||_|"
                  "                           "])))

(t/deftest "Recognizes 2"
  (t/assert-equal "2"
    (sol/convert [" _ "
                  " _|"
                  "|_ "
                  "   "])))

(t/deftest "Recognizes 3"
  (t/assert-equal "3"
    (sol/convert [" _ "
                  " _|"
                  " _|"
                  "   "])))

(t/deftest "Recognizes 4"
  (t/assert-equal "4"
    (sol/convert ["   "
                  "|_|"
                  "  |"
                  "   "])))

(t/deftest "Recognizes 5"
  (t/assert-equal "5"
    (sol/convert [" _ "
                  "|_ "
                  " _|"
                  "   "])))

(t/deftest "Recognizes 6"
  (t/assert-equal "6"
    (sol/convert [" _ "
                  "|_ "
                  "|_|"
                  "   "])))

(t/deftest "Recognizes 7"
  (t/assert-equal "7"
    (sol/convert [" _ "
                  "  |"
                  "  |"
                  "   "])))

(t/deftest "Recognizes 8"
  (t/assert-equal "8"
    (sol/convert [" _ "
                  "|_|"
                  "|_|"
                  "   "])))

(t/deftest "Recognizes 9"
  (t/assert-equal "9"
    (sol/convert [" _ "
                  "|_|"
                  " _|"
                  "   "])))

(t/deftest "Recognizes string of decimal numbers"
  (t/assert-equal "1234567890"
    (sol/convert ["    _  _     _  _  _  _  _  _ "
                  "  | _| _||_||_ |_   ||_||_|| |"
                  "  ||_  _|  | _||_|  ||_| _||_|"
                  "                              "])))

(t/deftest "Numbers separated by empty lines are recognized. Lines are joined by commas."
  (t/assert-equal "123,456,789"
    (sol/convert ["    _  _ "
                  "  | _| _|"
                  "  ||_  _|"
                  "         "
                  "    _  _ "
                  "|_||_ |_ "
                  "  | _||_|"
                  "         "
                  " _  _  _ "
                  "  ||_||_|"
                  "  ||_| _|"
                  "         "])))

(t/run)
