(import test :as t)
(import ../isogram :as sol)

(t/deftest "empty string"
  (t/assert-true (sol/isogram? "")))

(t/deftest "isogram with only lower case characters"
  (t/assert-true (sol/isogram? "isogram")))

(t/deftest "word with one duplicated character"
  (t/assert-false (sol/isogram? "eleven")))

(t/deftest "word with one duplicated character from the end of the alphabet"
  (t/assert-false (sol/isogram? "zzyzx")))

(t/deftest "longest reported english isogram"
  (t/assert-true (sol/isogram? "subdermatoglyphic")))

(t/deftest "word with duplicated character in mixed case"
  (t/assert-false (sol/isogram? "Alphabet")))

(t/deftest "word with duplicated character in mixed case, lowercase first"
  (t/assert-false (sol/isogram? "alphAbet")))

(t/deftest "hypothetical isogrammic word with hyphen"
  (t/assert-true (sol/isogram? "thumbscrew-japingly")))

(t/deftest "hypothetical word with duplicated character following hyphen"
  (t/assert-false (sol/isogram? "thumbscrew-jappingly")))

(t/deftest "isogram with duplicated hyphen"
  (t/assert-true (sol/isogram? "six-year-old")))

(t/deftest "made-up name that is an isogram"
  (t/assert-true (sol/isogram? "Emily Jung Schwartzkopf")))

(t/deftest "duplicated character in the middle"
  (t/assert-false (sol/isogram? "accentor")))

(t/deftest "same first and last characters"
  (t/assert-false (sol/isogram? "angola")))

(t/deftest "word with duplicated character and with two hyphens"
  (t/assert-false (sol/isogram? "up-to-date")))

(t/run)
